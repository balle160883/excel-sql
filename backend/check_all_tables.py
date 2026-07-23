from database import engine
from sqlalchemy import text

def get_all_tables():
    with engine.connect() as conn:
        query = text("""
            SELECT table_name 
            FROM information_schema.tables 
            WHERE table_schema = 'public' 
              AND table_name NOT IN ('users', 'user_permissions', 'audit_logs')
            ORDER BY table_name
        """)
        result = conn.execute(query)
        return [row.table_name for row in result]

def get_table_info(table_name):
    with engine.connect() as conn:
        # Obtener columnas
        col_query = text("""
            SELECT column_name, data_type, is_nullable
            FROM information_schema.columns 
            WHERE table_name = :table_name
            ORDER BY ordinal_position
        """)
        cols = conn.execute(col_query, {"table_name": table_name})
        columns = [{"name": c.column_name, "type": c.data_type, "nullable": c.is_nullable} for c in cols]
        
        # Obtener PK
        pk_query = text("""
            SELECT kcu.column_name
            FROM information_schema.table_constraints tco
            JOIN information_schema.key_column_usage kcu 
              ON kcu.constraint_name = tco.constraint_name
              AND kcu.constraint_schema = tco.constraint_schema
            WHERE tco.constraint_type = 'PRIMARY KEY'
              AND kcu.table_name = :table_name
        """)
        pk_result = conn.execute(pk_query, {"table_name": table_name}).fetchone()
        pk_column = pk_result.column_name if pk_result else None
        
        # Obtener primer registro
        try:
            data_query = text(f'SELECT * FROM "{table_name}" LIMIT 1')
            data_result = conn.execute(data_query).fetchone()
            sample_data = dict(data_result._mapping) if data_result else None
        except Exception as e:
            sample_data = f"Error: {str(e)}"
        
        return {
            "table_name": table_name,
            "columns": columns,
            "pk_column": pk_column,
            "sample_data": sample_data
        }

def main():
    print("="*80)
    print("ANÁLISIS COMPLETO DE TODAS LAS TABLAS")
    print("="*80)
    
    tables = get_all_tables()
    print(f"\nTotal de tablas encontradas: {len(tables)}\n")
    
    all_info = []
    for table in tables:
        print("-"*80)
        print(f"📊 Tabla: {table}")
        print("-"*80)
        
        info = get_table_info(table)
        all_info.append(info)
        
        print(f"\n🔑 Primary Key: {info['pk_column'] or 'NO TIENE'}")
        
        print("\n📋 Columnas:")
        for col in info['columns']:
            null_status = "Nullable" if col['nullable'] == 'YES' else "Not Null"
            print(f"  • {col['name']:30} ({col['type']:15}) - {null_status}")
        
        if info['sample_data']:
            if isinstance(info['sample_data'], dict):
                print("\n📄 Muestra de datos (primer registro):")
                for k, v in list(info['sample_data'].items())[:5]:  # Mostrar solo primeros 5 campos
                    print(f"  • {k}: {v}")
                if len(info['sample_data']) > 5:
                    print(f"  ... y {len(info['sample_data']) - 5} campos más")
            else:
                print(f"\n⚠️  {info['sample_data']}")
        else:
            print("\n⚠️  No hay datos en esta tabla")
        
        print("\n✅ Estructura compatible para edición" if info['pk_column'] else "\n❌ NO SE PUEDE EDITAR: No hay Primary Key")
        print()
    
    # Resumen final
    print("="*80)
    print("RESUMEN FINAL")
    print("="*80)
    print(f"\nTotal tablas: {len(all_info)}")
    editable = sum(1 for info in all_info if info['pk_column'])
    print(f"Tablas con PK (se pueden editar): {editable}")
    print(f"Tablas sin PK (no se pueden editar): {len(all_info) - editable}")
    
    if editable < len(all_info):
        print("\n⚠️  Tablas que no se pueden editar:")
        for info in all_info:
            if not info['pk_column']:
                print(f"  • {info['table_name']}")
    
    print("\n✨ Verificación completa!")

if __name__ == "__main__":
    main()
