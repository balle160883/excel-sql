from database import engine
from sqlalchemy import text

def analyze_table(table_name):
    with engine.connect() as conn:
        print(f"\n=== ANÁLISIS DE {table_name} ===")
        
        # Verificar si es una vista
        view_query = text("""
            SELECT table_type 
            FROM information_schema.tables 
            WHERE table_name = :table_name
        """)
        result = conn.execute(view_query, {"table_name": table_name}).fetchone()
        table_type = result.table_type if result else "UNKNOWN"
        print(f"Tipo: {table_type}")
        
        # Verificar datos completos
        try:
            data_query = text(f'SELECT * FROM "{table_name}" LIMIT 3')
            data_result = conn.execute(data_query)
            rows = [dict(row._mapping) for row in data_result]
            
            print(f"\nTotal de registros (aproximado): {len(rows)}")
            if rows:
                print("\nPrimeros 3 registros:")
                for i, row in enumerate(rows):
                    print(f"\nRegistro {i+1}:")
                    for k, v in row.items():
                        print(f"  {k}: {v}")
        except Exception as e:
            print(f"\nError: {e}")

def main():
    analyze_table("vista_sucursales")
    analyze_table("catalogo_soporte")

if __name__ == "__main__":
    main()
