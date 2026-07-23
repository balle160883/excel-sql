import pandas as pd
import os

file_path = "01.-Matriz de Conocimiento.xlsx"

try:
    xl = pd.ExcelFile(file_path)
    print(f"Hojas encontradas: {xl.sheet_names}")
    
    for sheet in xl.sheet_names:
        print(f"\n--- Hoja: {sheet} ---")
        df = pd.read_excel(file_path, sheet_name=sheet, nrows=5)
        print(f"Columnas: {list(df.columns)}")
        print("Primeras 5 filas:")
        print(df.head())
except Exception as e:
    print(f"Error leyendo el archivo: {e}")
