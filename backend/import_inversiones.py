import pandas as pd
from sqlalchemy import create_engine, text
import os

DATABASE_URL = "postgresql://postgres:postgres@sas_porter_db:5432/sas_db"
FILE_PATH = "/app/Solo_Inversiones_Para_Subir.xlsx"

def clean_column_name(name):
    if not isinstance(name, str):
        return f"col_{name}"
    name = name.strip().lower()
    name = name.replace("(", "_").replace(")", "_").replace("*", "")
    name = name.replace(" ", "_").replace(".", "").replace("-", "_")
    name = name.replace("á", "a").replace("é", "e").replace("í", "i").replace("ó", "o").replace("ú", "u")
    while "__" in name:
        name = name.replace("__", "_")
    name = name.strip("_")
    return name

def import_inversiones():
    print("Iniciando importación especial de Inversiones...")
    engine = create_engine(DATABASE_URL)
    xl = pd.ExcelFile(FILE_PATH)
    
    with engine.begin() as connection:
        for sheet in xl.sheet_names:
            print(f"Procesando hoja: {sheet}")
            df = pd.read_excel(FILE_PATH, sheet_name=sheet)
            
            # Limpiar columnas
            df.columns = [clean_column_name(c) for c in df.columns]
            
            # Eliminar columnas vacías/unnamed/validada/etc.
            df = df.loc[:, (~df.columns.str.contains('^unnamed')) & (df.columns != "")]
            if 'validada' in df.columns:
                df = df.drop(columns=['validada'])
            
            # Quitar columnas que empiezan con col_ si son de espacios en blanco
            df = df.loc[:, ~df.columns.str.contains('^col_')]
            
            # Eliminar filas vacías
            df = df.dropna(how='all')
            
            table_name = clean_column_name(sheet)
            print(f"Guardando en tabla SQL: {table_name} ({len(df)} filas)")
            df.to_sql(table_name, connection, if_exists='replace', index=False)
            
            # Compatibilidad: Si estamos cargando Catalogo_Inversiones, creamos una copia como tablas_inversiones
            if table_name == "catalogo_inversiones":
                print("Guardando copia de compatibilidad en tabla SQL: tablas_inversiones")
                df.to_sql("tablas_inversiones", connection, if_exists='replace', index=False)
            
    print("Importación de Inversiones completada exitosamente.")

if __name__ == "__main__":
    import_inversiones()
