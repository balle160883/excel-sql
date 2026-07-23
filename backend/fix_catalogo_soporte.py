from database import engine
from sqlalchemy import text

def main():
    with engine.begin() as conn:  # Usamos begin() para transacción
        print("=== Agregando Primary Key a catalogo_soporte ===")
        
        # Verificar que la columna id exista y no sea null
        verify_query = text("""
            SELECT column_name, is_nullable 
            FROM information_schema.columns 
            WHERE table_name = 'catalogo_soporte' AND column_name = 'id'
        """)
        col_info = conn.execute(verify_query).fetchone()
        print(f"Columna 'id' encontrada: {col_info}")
        
        # Asegurarse que id no tenga valores nulos
        null_check = text('SELECT COUNT(*) FROM "catalogo_soporte" WHERE id IS NULL')
        null_count = conn.execute(null_check).scalar()
        print(f"Valores NULL en id: {null_count}")
        
        if null_count > 0:
            print("⚠️  Hay valores NULL en la columna id!")
            return
        
        # Agregar la constraint de Primary Key
        try:
            alter_query = text('ALTER TABLE "catalogo_soporte" ADD PRIMARY KEY (id)')
            conn.execute(alter_query)
            print("✅ Primary Key agregada exitosamente!")
        except Exception as e:
            print(f"Error: {e}")
            print("Probablemente la PK ya existe.")

if __name__ == "__main__":
    main()
