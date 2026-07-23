import pandas as pd
import os
from sqlalchemy import create_engine, text

# Configuración
DATABASE_URL = "postgresql://postgres:postgres@sas_porter_db:5432/sas_db"

def clean_column_name(name):
    if not isinstance(name, str):
        return f"col_{name}"
    name = name.strip().lower()
    name = name.replace(" ", "_").replace(".", "").replace("-", "_")
    name = name.replace("á", "a").replace("é", "e").replace("í", "i").replace("ó", "o").replace("ú", "u")
    
    # Estandarizar keywords
    if name in ['keywords_busqueda', 'preguntas_usuario', 'key_words']:
        return 'keywords'
    return name if name else "col"

def import_data():
    file_path = "01.-Matriz nuevo.xlsx"
    if not os.path.exists(file_path):
        file_path = "01.-Matriz de Conocimiento.xlsx"
        
    print(f"Iniciando importación INTERNAL desde {file_path}...")
    try:
        engine = create_engine(DATABASE_URL)
        xl = pd.ExcelFile(file_path)
        
        # Usamos engine directo, dentro del container las versiones deberían ser compatibles (pinned in requirements?)
        # O usamos connection explícito. Probemos explícito.
        with engine.begin() as connection:
            for sheet in xl.sheet_names:
                print(f"Procesando hoja: {sheet}")
                
                df_check = pd.read_excel(file_path, sheet_name=sheet, header=None, nrows=2)
                non_null_count_row0 = df_check.iloc[0].count()
                
                header_row = 0
                if non_null_count_row0 <= 1:
                    print(f"  -> Detectado título en fila 0, usando fila 1 como header.")
                    header_row = 1
                elif len(df_check) > 1:
                    non_null_count_row1 = df_check.iloc[1].count()
                    if non_null_count_row1 > 0 and non_null_count_row0 < non_null_count_row1 * 0.3:
                        print(f"  -> Detectada cabecera de agrupación en fila 0, usando fila 1 como header.")
                        header_row = 1
                
                df = pd.read_excel(file_path, sheet_name=sheet, header=header_row)
                
                df.columns = [clean_column_name(c) for c in df.columns]
                df = df.loc[:, ~df.columns.str.contains('^unnamed')]
                
                if df.empty:
                    print(f"  -> Hoja vacía. Saltando.")
                    continue

                table_name = clean_column_name(sheet)
                
                print(f"  -> Guardando en tabla SQL: {table_name} ({len(df)} filas)")
                df.to_sql(table_name, connection, if_exists='replace', index=False)
                
                # Agregar Primary Key
                first_col = df.columns[0]
                try:
                    connection.execute(text(f'ALTER TABLE "{table_name}" ALTER COLUMN "{first_col}" SET NOT NULL'))
                    connection.execute(text(f'ALTER TABLE "{table_name}" ADD PRIMARY KEY ("{first_col}")'))
                    print(f"  -> ✅ Primary Key agregada en '{first_col}' para '{table_name}'")
                except Exception as pk_err:
                    print(f"  -> ⚠️ No se pudo agregar PK a '{table_name}': {pk_err}")
            
        print("\nImportación completada exitosamente.")
        
    except Exception as e:
        print(f"Error crítico durante la importación: {e}")

if __name__ == "__main__":
    import_data()
