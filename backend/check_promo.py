
from sqlalchemy import create_engine, text
import os

DATABASE_URL = "postgresql://postgres:postgres@sas_db:5432/sas_db"
engine = create_engine(DATABASE_URL)

def list_all_tables():
    with engine.connect() as conn:
        # Listar todas las tablas
        query = text("""
            SELECT table_name 
            FROM information_schema.tables 
            WHERE table_schema = 'public' 
              AND table_name NOT IN ('users', 'user_permissions', 'audit_logs')
            ORDER BY table_name
        """)
        result = conn.execute(query)
        
        print("Todas las tablas disponibles en la base de datos:")
        print("-" * 50)
        tables = []
        for row in result:
            tables.append(row.table_name)
            print(f"- {row.table_name}")
        
        if not tables:
            print("No hay tablas disponibles")
            return
        
        # Verificar todas las tablas que contengan "sucursal" en el nombre
        print("\n" + "=" * 50)
        print("Tablas que contienen 'sucursal' en el nombre:")
        print("-" * 50)
        
        for table in tables:
            if 'sucursal' in table.lower():
                print(f"\n--- Tabla: {table} ---")
                # Obtener columnas
                col_query = text("""
                    SELECT column_name, data_type 
                    FROM information_schema.columns 
                    WHERE table_name = :tn 
                    ORDER BY ordinal_position
                """)
                cols = conn.execute(col_query, {"tn": table})
                print("Columnas:")
                for col in cols:
                    print(f"  - {col.column_name} ({col.data_type})")
                
                # Obtener primer registro
                data_query = text(f"SELECT * FROM {table} LIMIT 1")
                data = conn.execute(data_query).fetchone()
                if data:
                    print("\nPrimer registro:")
                    for key, val in dict(data._mapping).items():
                        print(f"  {key}: {val}")

if __name__ == "__main__":
    list_all_tables()
