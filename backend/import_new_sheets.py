import pandas as pd
from sqlalchemy import create_engine, text
import re
import os

DATABASE_URL = "postgresql://postgres:postgres@sas_db:5432/sas_db"
FILE_PATH = "01.-Matriz nuevo.xlsx"

def clean_col(name):
    if not isinstance(name, str):
        return f"col_{name}"
    name = name.strip()
    for a, b in [("á","a"),("é","e"),("í","i"),("ó","o"),("ú","u"),
                 ("Á","a"),("É","e"),("Í","i"),("Ó","o"),("Ú","u"),("ñ","n"),("Ñ","n")]:
        name = name.replace(a, b)
    name = re.sub(r"[^a-zA-Z0-9]", "_", name)
    name = re.sub(r"_+", "_", name).strip("_").lower()
    
    # Estandarizar keywords
    if name in ['keywords_busqueda', 'preguntas_usuario', 'key_words']:
        return 'keywords'
    return name if name else "col"

def detect_header_row(df_raw):
    if len(df_raw) == 0:
        return 0
    row0_vals = df_raw.iloc[0].dropna()
    if len(row0_vals) <= 1 and len(df_raw) > 1:
        row1_vals = df_raw.iloc[1].dropna()
        if len(row1_vals) > 1:
            return 1
    if len(df_raw) > 1:
        row1_vals = df_raw.iloc[1].dropna()
        if len(row1_vals) > 0 and len(row0_vals) < len(row1_vals) * 0.3:
            return 1
    return 0

def import_sheet(xl, sheet_name, engine):
    print(f"\nProcesando hoja: {sheet_name}")
    df_raw = pd.read_excel(xl, sheet_name=sheet_name, header=None)
    header_row = detect_header_row(df_raw)
    
    df = pd.read_excel(xl, sheet_name=sheet_name, header=header_row)
    df.columns = [clean_col(c) for c in df.columns]
    
    # Eliminar columnas sin nombre
    df = df.loc[:, ~df.columns.str.match(r"^unnamed_\d+$")]
    df = df.loc[:, (df.columns != "") & (~df.columns.str.startswith("col_"))]
    df = df.dropna(how="all")
    
    table_name = clean_col(sheet_name)
    print(f"-> Guardando en tabla SQL: '{table_name}' ({len(df)} filas)")
    
    with engine.begin() as conn:
        # Importar datos
        df.to_sql(table_name, conn, if_exists="replace", index=False)
        
        # Agregar Primary Key a la primera columna
        first_col = df.columns[0]
        try:
            # Asegurar que no sea nula para poder ser PK
            conn.execute(text(f'ALTER TABLE "{table_name}" ALTER COLUMN "{first_col}" SET NOT NULL'))
            conn.execute(text(f'ALTER TABLE "{table_name}" ADD PRIMARY KEY ("{first_col}")'))
            print(f"✅ Primary Key agregada en columna '{first_col}' para tabla '{table_name}'")
        except Exception as pk_err:
            print(f"⚠️ No se pudo agregar PK a '{table_name}': {pk_err}")
            
    return table_name, len(df)

def main():
    if not os.path.exists(FILE_PATH):
        print(f"Error: Archivo no encontrado {FILE_PATH}")
        return
        
    engine = create_engine(DATABASE_URL)
    xl = pd.ExcelFile(FILE_PATH)
    
    target_sheets = [
        'Tramites_y_servicios',
        'Limites_Transaccionales',
        'Catalogo_Conceptos_Cooperativos'
    ]
    
    imported = []
    for sheet in target_sheets:
        if sheet in xl.sheet_names:
            try:
                table_name, rows = import_sheet(xl, sheet, engine)
                imported.append((sheet, table_name, rows))
            except Exception as e:
                print(f"❌ Error al importar '{sheet}': {e}")
        else:
            print(f"⚠️ La hoja '{sheet}' no existe en el archivo Excel.")
            
    print("\n" + "=" * 50)
    print("RESUMEN DE IMPORTACIÓN DE NUEVAS HOJAS")
    print("=" * 50)
    for sheet, table, rows in imported:
        print(f"✅ {sheet} -> '{table}' ({rows} filas)")
    print("=" * 50)

if __name__ == "__main__":
    main()
