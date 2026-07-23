
import pandas as pd
import os

FILE_PATH = "01.-Matriz de Conocimiento.xlsx"

def analyze_excel():
    if not os.path.exists(FILE_PATH):
        print(f"File not found: {FILE_PATH}")
        return

    xl = pd.ExcelFile(FILE_PATH)
    print(f"{'Sheet Name':<40} | {'Rows':<10} | {'Columns':<10}")
    print("-" * 65)
    for sheet in xl.sheet_names:
        df_raw = pd.read_excel(xl, sheet_name=sheet, header=None)
        
        # Header detection logic from processor.py
        header_row = 0
        if len(df_raw) > 0 and df_raw.iloc[0].count() <= 1:
            header_row = 1
            
        df = pd.read_excel(xl, sheet_name=sheet, header=header_row)
        # Drop completely empty rows
        df_clean = df.dropna(how='all')
        print(f"{sheet:<40} | {len(df_clean):<10} | {len(df_clean.columns):<10}")

if __name__ == "__main__":
    analyze_excel()
