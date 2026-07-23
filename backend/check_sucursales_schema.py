from database import engine
from sqlalchemy import text

with engine.connect() as conn:
    # Verificar columnas de la tabla sucursales
    query = text("""
        SELECT column_name, data_type 
        FROM information_schema.columns 
        WHERE table_name = 'sucursales' 
        ORDER BY ordinal_position
    """)
    result = conn.execute(query)
    
    print("Columnas de la tabla 'sucursales':")
    print("-" * 50)
    for row in result:
        print(f"- {row.column_name} ({row.data_type})")
    
    # Verificar algunos datos de ejemplo
    print("\n" + "=" * 50)
    print("Primeros 3 registros de la tabla:")
    print("-" * 50)
    
    query_data = text("SELECT * FROM sucursales LIMIT 3")
    result_data = conn.execute(query_data)
    
    for i, row in enumerate(result_data):
        print(f"\nRegistro {i+1}:")
        for key, value in dict(row._mapping).items():
            print(f"  {key}: {value}")
