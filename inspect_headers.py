import pandas as pd

file_path = "01.-Matriz de Conocimiento.xlsx"
sheets_to_check = ['Tablas_Inversiones', 'Tablas_Credito', 'Tabla_requisitos', 'Tabla_Servicios', 'Tabla_Protecciones']

try:
    for sheet in sheets_to_check:
        print(f"\n--- Investigando Hoja: {sheet} ---")
        # Leer primeras 5 filas sin header para ver la estructura bruta
        df = pd.read_excel(file_path, sheet_name=sheet, header=None, nrows=5)
        print(df)
except Exception as e:
    print(f"Error: {e}")
