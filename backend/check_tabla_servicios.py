from database import engine
from sqlalchemy import text

with engine.connect() as conn:
    # Verificar estructura de la tabla
    query = text("""
        SELECT column_name, data_type, is_nullable 
        FROM information_schema.columns 
        WHERE table_name = 'tabla_servicios' 
        ORDER BY ordinal_position
    """)
    result = conn.execute(query)
    
    print("Estructura de tabla_servicios:")
    print("-" * 60)
    for row in result:
        print(f"{row.column_name:<25} {row.data_type:<15} Nullable: {row.is_nullable}")
    
    print("\n" + "=" * 60)
    print("Primer registro:")
    print("-" * 60)
    
    data_query = text("SELECT * FROM tabla_servicios LIMIT 1")
    data_result = conn.execute(data_query).fetchone()
    if data_result:
        for key, value in dict(data_result._mapping).items():
            print(f"{key}: {value}")
