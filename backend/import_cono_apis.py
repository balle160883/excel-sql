
import pandas as pd
from sqlalchemy import create_engine, text
import re
import os

DATABASE_URL = "postgresql://postgres:postgres@sas_db:5432/sas_db"
FILE_PATH = "Cono-apis.xlsx"

def clean_col(name):
    if not isinstance(name, str):
        return f"col_{name}"
    name = name.strip()
    for a, b in [("á","a"),("é","e"),("í","i"),("ó","o"),("ú","u"),
                 ("Á","a"),("É","e"),("Í","i"),("Ó","o"),("Ú","u"),("ñ","n"),("Ñ","n")]:
        name = name.replace(a, b)
    name = re.sub(r"[^a-zA-Z0-9]", "_", name)
    name = re.sub(r"_+", "_", name).strip("_").lower()
    return name if name else "col"

def detect_header_row(df_raw):
    if len(df_raw) == 0: return 0
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
    df_raw = pd.read_excel(xl, sheet_name=sheet_name, header=None)
    header_row = detect_header_row(df_raw)
    df = pd.read_excel(xl, sheet_name=sheet_name, header=header_row)
    df.columns = [clean_col(c) for c in df.columns]
    df = df.loc[:, ~df.columns.str.match(r"^unnamed_\d+$")]
    df = df.loc[:, (df.columns != "") & (~df.columns.str.startswith("col_"))]
    df = df.dropna(how="all")
    
    table_name = clean_col(sheet_name)
    if sheet_name == 'Catalago_soporte':
        table_name = 'catalago_soporte'
    
    print(f"Importing {sheet_name} -> {table_name} ({len(df)} rows)")
    
    # Manejar dependencias si existen (vistas)
    with engine.begin() as conn:
        if table_name in ['tabla_sucursales', 'tabla_horarios']:
            conn.execute(text("DROP VIEW IF EXISTS vista_sucursales CASCADE"))
        df.to_sql(table_name, conn, if_exists="replace", index=False)
    return table_name, len(df)

def recreate_view(engine):
    with engine.begin() as conn:
        conn.execute(text("""
            CREATE OR REPLACE VIEW vista_sucursales AS 
            SELECT s.*, h.descripcion as horario_descripcion, h.hora_apertura, h.hora_cierre, h.hora_apertura_sab, h.hora_cierre_sab 
            FROM tabla_sucursales s 
            LEFT JOIN tabla_horarios h ON s.id_horario = h.id_horario
        """))
    print("View vista_sucursales recreated.")

def main():
    if not os.path.exists(FILE_PATH):
        print(f"File not found: {FILE_PATH}")
        return
    engine = create_engine(DATABASE_URL)
    xl = pd.ExcelFile(FILE_PATH)
    for sheet in xl.sheet_names:
        try:
            import_sheet(xl, sheet, engine)
        except Exception as e:
            print(f"Error in {sheet}: {e}")
    
    try:
        recreate_view(engine)
    except Exception as e:
        print(f"Error recreating view: {e}")

if __name__ == "__main__":
    main()
