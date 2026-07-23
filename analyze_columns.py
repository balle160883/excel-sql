import pandas as pd
import os

file_path = "01.-Matriz de Conocimiento.xlsx"

try:
    xl = pd.ExcelFile(file_path)
    print(f"Hojas: {xl.sheet_names}")
    
    for sheet in xl.sheet_names:
        df = pd.read_excel(file_path, sheet_name=sheet, nrows=0) # No leer filas, solo headers
        print(f"Hoja '{sheet}' Columnas: {list(df.columns)}")
except Exception as e:
    print(f"Error: {e}")
