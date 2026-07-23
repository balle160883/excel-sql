import pandas as pd
import PyPDF2
from docx import Document
import io
from sqlalchemy import Table, Column, String, Float, MetaData, Integer, text, inspect

class FileProcessor:
    def __init__(self):
        self.metadata = MetaData()

    def process_excel(self, content: bytes):
        """Lee todas las hojas de un archivo Excel y devuelve un diccionario {nombre_hoja: dataframe}"""
        xl = pd.ExcelFile(io.BytesIO(content))
        sheets = {}
        for sheet_name in xl.sheet_names:
            # Leer check para cabecera (como en import_internal.py)
            df_check = pd.read_excel(xl, sheet_name=sheet_name, header=None, nrows=2)
            header_row = 0
            if len(df_check) > 0:
                row0_count = df_check.iloc[0].count()
                if row0_count <= 1:
                    header_row = 1
                elif len(df_check) > 1:
                    row1_count = df_check.iloc[1].count()
                    if row1_count > 0 and row0_count < row1_count * 0.3:
                        header_row = 1
            
            df = pd.read_excel(xl, sheet_name=sheet_name, header=header_row)
            sheets[sheet_name] = df
        return sheets

    def process_csv(self, content: bytes, filename: str):
        df = pd.read_csv(io.BytesIO(content))
        return df

    def extract_text_from_pdf(self, content: bytes):
        reader = PyPDF2.PdfReader(io.BytesIO(content))
        text = ""
        for page in reader.pages:
            text += page.extract_text()
        return text

    def extract_text_from_docx(self, content: bytes):
        doc = Document(io.BytesIO(content))
        text = "\n".join([para.text for para in doc.paragraphs])
        return text

    def clean_name(self, name: str):
        if not isinstance(name, str):
            return f"col_{name}"
        name = name.strip().lower()
        # Eliminar caracteres especiales problemáticos para SQL
        name = name.replace("(", "_").replace(")", "_").replace("*", "")
        name = name.replace(" ", "_").replace(".", "").replace("-", "_")
        name = name.replace("á", "a").replace("é", "e").replace("í", "i").replace("ó", "o").replace("ú", "u")
        # Eliminar guiones bajos duplicados resultantes de las sustituciones
        while "__" in name:
            name = name.replace("__", "_")
        name = name.strip("_")
        
        # Quitar extensiones si vienen en el nombre
        name = name.replace(".xlsx", "").replace(".csv", "")
        
        # Estandarizar keywords para el chatbot
        if name in ['keywords_busqueda', 'preguntas_usuario', 'key_words']:
            return 'keywords'
        return name

    def create_dynamic_table(self, df: pd.DataFrame, table_name: str, engine):
        # Limpiar nombre de tabla
        table_name = self.clean_name(table_name)
        
        # Limpiar nombres de columnas
        df.columns = [self.clean_name(c) for c in df.columns]
        
        # Eliminar columnas sin nombre (provenientes de celdas vacías en Excel) o que quedaron vacías tras limpiar
        df = df.loc[:, (~df.columns.str.contains('^unnamed')) & (df.columns != "")]
        
        if df.empty:
            return table_name

        # Manejar dependencias de vistas en PostgreSQL si existen para evitar errores de DependentObjectsStillExist
        if table_name in ['tabla_sucursales', 'tabla_horarios']:
            with engine.begin() as conn:
                conn.execute(text("DROP VIEW IF EXISTS vista_sucursales CASCADE"))

        print(f"Guardando tabla {table_name} con {len(df)} filas (Modo: REPLACE)")
        
        # Insertar datos - Usamos 'replace' para actualizar la información
        df.to_sql(table_name, engine, if_exists='replace', index=False)

        # Agregar PRIMARY KEY a la primera columna si no existe (pandas no crea constraints)
        # Esto es necesario para que EDITAR y ELIMINAR funcionen correctamente
        try:
            first_col = df.columns[0]
            with engine.begin() as conn_pk:
                # Verificar si ya existe una PK
                pk_check = conn_pk.execute(text("""
                    SELECT COUNT(*) FROM information_schema.table_constraints
                    WHERE constraint_type = 'PRIMARY KEY' AND table_name = :tn
                """), {"tn": table_name}).scalar()
                if pk_check == 0:
                    conn_pk.execute(text(f'ALTER TABLE "{table_name}" ADD PRIMARY KEY ("{first_col}")'))
                    print(f"Primary Key agregada en columna '{first_col}' para tabla '{table_name}'")
        except Exception as pk_err:
            print(f"Advertencia: No se pudo agregar PK automáticamente a '{table_name}': {pk_err}")

        # Recrear la vista si ambas tablas existen
        if table_name in ['tabla_sucursales', 'tabla_horarios']:
            inspector = inspect(engine)
            if inspector.has_table('tabla_sucursales') and inspector.has_table('tabla_horarios'):
                with engine.begin() as conn:
                    conn.execute(text("""
                        CREATE OR REPLACE VIEW vista_sucursales AS 
                        SELECT s.*, h.descripcion as horario_descripcion, h.hora_apertura, h.hora_cierre, h.hora_apertura_sab, h.hora_cierre_sab 
                        FROM tabla_sucursales s 
                        LEFT JOIN tabla_horarios h ON s.id_horario = h.id_horario
                    """))

        return table_name
