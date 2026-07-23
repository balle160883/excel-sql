
import pandas as pd
import os

FILE_PATH = "01.-Matriz de Conocimiento.xlsx"

def check_sheets():
    xl = pd.ExcelFile(FILE_PATH)
    for sheet in xl.sheet_names:
        df_raw = pd.read_excel(xl, sheet_name=sheet, header=None)
        header_row = 0
        if len(df_raw) > 0 and df_raw.iloc[0].count() <= 1:
            header_row = 1
        df = pd.read_excel(xl, sheet_name=sheet, header=header_row)
        df = df.dropna(how='all')
        print(f"Sheet: {sheet} | Rows: {len(df)}")
        if sheet == 'Tabla_Ahorro':
            print(df.iloc[:, 0].tolist()) # Print first column to see IDs

if __name__ == "__main__":
    check_sheets()
