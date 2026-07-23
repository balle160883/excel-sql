"""
import_full_matrix.py
--------------------
Importa TODAS las hojas del Excel '01.-Matriz de Conocimiento.xlsx'
a PostgreSQL, reemplazando los datos existentes de forma íntegra.

Lógica inteligente:
- Detecta si la fila 0 es un título decorativo (1 sola celda con texto)
  y en ese caso usa la fila 1 como cabecera real.
- Limpia nombres de columnas para que sean válidos en SQL.
- Elimina filas y columnas completamente vacías.
- Usa IF_EXISTS='replace' para sobrescribir cada tabla.
"""

import pandas as pd
from sqlalchemy import create_engine, text
import re
import os

DATABASE_URL = "postgresql://postgres:postgres@sas_db:5432/sas_db"


def clean_col(name):
    """Convierte un nombre de columna de Excel en un nombre SQL válido."""
    if not isinstance(name, str):
        return f"col_{name}"
    name = name.strip()
    # Reemplazar acentos
    for a, b in [("á","a"),("é","e"),("í","i"),("ó","o"),("ú","u"),
                 ("Á","a"),("É","e"),("Í","i"),("Ó","o"),("Ú","u"),("ñ","n"),("Ñ","n")]:
        name = name.replace(a, b)
    # Reemplazar caracteres no alfanuméricos con _
    name = re.sub(r"[^a-zA-Z0-9]", "_", name)
    # Colapsar múltiples _ y quitar del inicio/fin
    name = re.sub(r"_+", "_", name).strip("_").lower()
    
    # Estandarizar keywords
    if name in ['keywords_busqueda', 'preguntas_usuario', 'key_words']:
        return 'keywords'
    return name if name else "col"


def detect_header_row(df_raw):
    """
    Detecta si la fila 0 es un título decorativo o cabecera de agrupación.
    Heurística: si la fila 0 tiene sólo 1 valor no-nulo y la fila 1
    tiene varios valores no-nulos, la fila 0 es título.
    También si la fila 0 tiene significativamente menos elementos no nulos que la fila 1 (menos del 30%).
    """
    row0_vals = df_raw.iloc[0].dropna()
    if len(row0_vals) <= 1 and len(df_raw) > 1:
        row1_vals = df_raw.iloc[1].dropna()
        if len(row1_vals) > 1:
            return 1  # usar fila 1 como cabecera
    if len(df_raw) > 1:
        row1_vals = df_raw.iloc[1].dropna()
        if len(row1_vals) > 0 and len(row0_vals) < len(row1_vals) * 0.3:
            return 1
    return 0  # usar fila 0 como cabecera


def import_sheet(xl, sheet_name, engine, file_path):
    print(f"\n{'='*60}")
    print(f"  Procesando hoja: '{sheet_name}'")

    # Leer sin header para detectar estructura
    df_raw = pd.read_excel(xl, sheet_name=sheet_name, header=None)

    header_row = detect_header_row(df_raw)
    if header_row == 1:
        print(f"  → Fila 0 es título decorativo, usando fila 1 como cabecera.")

    # Leer con el header correcto
    df = pd.read_excel(xl, sheet_name=sheet_name, header=header_row)

    # Limpiar nombres de columnas
    df.columns = [clean_col(c) for c in df.columns]

    # Eliminar columnas completamente vacías o con nombre tipo unnamed
    df = df.loc[:, ~df.columns.str.match(r"^unnamed_\d+$")]
    df = df.loc[:, df.columns != ""]
    df = df.loc[:, ~df.columns.str.startswith("col_")]

    # Eliminar filas completamente vacías
    df = df.dropna(how="all")

    # Nombre de la tabla SQL
    table_name = clean_col(sheet_name)

    print(f"  → Tabla SQL: '{table_name}'")
    print(f"  → Columnas: {list(df.columns)}")
    print(f"  → Filas a importar: {len(df)}")

    # Importar a PostgreSQL
    with engine.begin() as conn:
        # Manejar dependencias si existen (vistas)
        if table_name in ['tabla_sucursales', 'tabla_horarios']:
            conn.execute(text("DROP VIEW IF EXISTS vista_sucursales CASCADE"))
        df.to_sql(table_name, conn, if_exists="replace", index=False)
        
        # Agregar Primary Key
        first_col = df.columns[0]
        try:
            conn.execute(text(f'ALTER TABLE "{table_name}" ALTER COLUMN "{first_col}" SET NOT NULL'))
            conn.execute(text(f'ALTER TABLE "{table_name}" ADD PRIMARY KEY ("{first_col}")'))
            print(f"  → ✅ Primary Key agregada en '{first_col}' para '{table_name}'")
        except Exception as pk_err:
            print(f"  → ⚠️ No se pudo agregar PK a '{table_name}': {pk_err}")

    print(f"  ✅ '{table_name}' importada con {len(df)} registros.")
    return table_name, len(df)


def main():
    print("=" * 60)
    print("  IMPORTACIÓN COMPLETA — Matriz de Conocimiento")
    print("=" * 60)

    # Detectar el archivo correcto
    file_path = "/app/01.-Matriz nuevo.xlsx"
    if not os.path.exists(file_path):
        file_path = "/app/01.-Matriz de Conocimiento.xlsx"

    if not os.path.exists(file_path):
        print(f"❌ Archivo no encontrado: {file_path}")
        return

    engine = create_engine(DATABASE_URL)
    xl = pd.ExcelFile(file_path)

    resultados = []
    errores = []

    for sheet in xl.sheet_names:
        try:
            table_name, rows = import_sheet(xl, sheet, engine, file_path)
            resultados.append((sheet, table_name, rows))
        except Exception as e:
            print(f"  ❌ Error en '{sheet}': {e}")
            errores.append((sheet, str(e)))

    # Recrear vista si se importaron las tablas correspondientes
    imported_tables = [r[1] for r in resultados]
    if 'tabla_sucursales' in imported_tables or 'tabla_horarios' in imported_tables:
        try:
            with engine.begin() as conn:
                conn.execute(text("""
                    CREATE OR REPLACE VIEW vista_sucursales AS 
                    SELECT s.*, h.descripcion as horario_descripcion, h.hora_apertura, h.hora_cierre, h.hora_apertura_sab, h.hora_cierre_sab 
                    FROM tabla_sucursales s 
                    LEFT JOIN tabla_horarios h ON s.id_horario = h.id_horario
                """))
            print("\n  ✅ Vista vista_sucursales recreada.")
        except Exception as ve:
            print(f"\n  ❌ Error recreando vista_sucursales: {ve}")

    # Resumen final
    print("\n" + "=" * 60)
    print("  RESUMEN FINAL")
    print("=" * 60)
    total_filas = 0
    for sheet, table, rows in resultados:
        print(f"  ✅ {sheet:40s} → {table:40s} ({rows} filas)")
        total_filas += rows

    if errores:
        print("\n  ❌ ERRORES:")
        for sheet, err in errores:
            print(f"  - {sheet}: {err}")

    print(f"\n  Total hojas importadas : {len(resultados)}")
    print(f"  Total filas importadas : {total_filas}")
    print(f"  Total errores          : {len(errores)}")
    print("=" * 60)


if __name__ == "__main__":
    main()
