from database import engine
from sqlalchemy import text

with engine.connect() as conn:
    # Consultar vista_sucursales como lo hace el backend
    query = text("SELECT * FROM vista_sucursales LIMIT 100 OFFSET 0")
    result = conn.execute(query)
    
    rows = [dict(row._mapping) for row in result]
    
    if rows:
        print("Resultado como lo devuelve el endpoint:")
        print(f"Data length: {len(rows)}")
        print(f"Columns from first row: {list(rows[0].keys())}")
        print(f"First row data: {rows[0]}")
    else:
        print("No data")
