import pandas as pd
import sys

file_path = "01.-Matriz de Conocimiento.xlsx"
output_file = "schema_info.txt"

with open(output_file, "w", encoding="utf-8") as f:
    try:
        xl = pd.ExcelFile(file_path)
        f.write(f"Sheets: {xl.sheet_names}\n")
        
        for sheet in xl.sheet_names:
            df = pd.read_excel(file_path, sheet_name=sheet, nrows=0)
            f.write(f"\nSHEET: {sheet}\n")
            f.write(f"COLUMNS: {list(df.columns)}\n")
    except Exception as e:
        f.write(f"Error: {e}\n")
