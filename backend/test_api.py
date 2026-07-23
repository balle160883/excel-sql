from database import engine
from sqlalchemy import text

with engine.connect() as conn:
    # Consultar vista_sucursales
    query = text("SELECT * FROM vista_sucursales LIMIT 1")
    result = conn.execute(query)
    row = result.fetchone()
    
    if row:
        print("Columnas en vista_sucursales:")
        print(list(row._mapping.keys()))
        print("\nDatos:")
        print(dict(row._mapping))
    else:
        print("No hay datos")
