
from sqlalchemy import create_engine, text, inspect
import os

DATABASE_URL = "postgresql://postgres:postgres@sas_db:5432/sas_db"
engine = create_engine(DATABASE_URL)

def check_data():
    insp = inspect(engine)
    with engine.connect() as conn:
        # Check Servicios IDs
        print("\n--- Tabla Servicios IDs ---")
        res = conn.execute(text("SELECT id FROM tabla_servicios"))
        ids = [r[0] for r in res]
        print(f"IDs present: {ids}")
        
        # Check Promociones
        print("\n--- Tabla Promociones ---")
        res = conn.execute(text("SELECT id, nombre_campana, descripcion_hook FROM tabla_promociones"))
        for row in res:
            print(dict(row._mapping))
            
        # Check Conceptos Cooperativos columns and data
        print("\n--- Tabla Conceptos Cooperativos ---")
        cols = [c['name'] for c in insp.get_columns('catalogo_conceptos_cooperativos')]
        print(f"Columns: {cols}")
        res = conn.execute(text("SELECT * FROM catalogo_conceptos_cooperativos LIMIT 5"))
        for row in res:
            print(dict(row._mapping))

if __name__ == "__main__":
    check_data()
