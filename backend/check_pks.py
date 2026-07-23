import psycopg2

# Intentar conexión a localhost (el puerto de PostgreSQL expuesto por Docker)
try:
    conn = psycopg2.connect(
        host='localhost',
        port=5432,
        database='sas_db',
        user='postgres',
        password='postgres'
    )
    print("Conexion exitosa a localhost:5432")
except Exception as e:
    print(f"Error de conexion: {e}")
    exit(1)

cur = conn.cursor()

# Obtener todas las tablas públicas excepto las del sistema
cur.execute("""
    SELECT table_name
    FROM information_schema.tables
    WHERE table_schema = 'public'
      AND table_type = 'BASE TABLE'
      AND table_name NOT IN ('users', 'user_permissions', 'audit_logs')
    ORDER BY table_name
""")
tables = [row[0] for row in cur.fetchall()]
print(f"\nTablas encontradas: {len(tables)}")
print("-" * 60)

alter_statements = []

for table in tables:
    # Verificar si ya tiene PK formal
    cur.execute("""
        SELECT kcu.column_name
        FROM information_schema.table_constraints tco
        JOIN information_schema.key_column_usage kcu
          ON kcu.constraint_name = tco.constraint_name
         AND kcu.constraint_schema = tco.constraint_schema
        WHERE tco.constraint_type = 'PRIMARY KEY'
          AND kcu.table_name = %s
    """, (table,))
    pk = cur.fetchone()

    # Primera columna de la tabla
    cur.execute("""
        SELECT column_name, data_type
        FROM information_schema.columns
        WHERE table_name = %s AND table_schema = 'public'
        ORDER BY ordinal_position
        LIMIT 1
    """, (table,))
    first_col_row = cur.fetchone()

    status = "OK (ya tiene PK)" if pk else "SIN PK"
    pk_name = pk[0] if pk else None
    first_col = first_col_row[0] if first_col_row else None
    first_type = first_col_row[1] if first_col_row else None

    print(f"  {table:<30} | {status:<18} | pk={pk_name or 'N/A':<20} | primera_col={first_col} ({first_type})")

    if not pk and first_col:
        alter_statements.append({
            "table": table,
            "col": first_col,
            "type": first_type
        })

cur.close()
conn.close()

print("\n" + "=" * 60)
print("SCRIPT SQL PARA AGREGAR PRIMARY KEYS:")
print("=" * 60)

if not alter_statements:
    print("Todas las tablas ya tienen PRIMARY KEY. No se necesita nada.")
else:
    print()
    for s in alter_statements:
        print(f'-- Tabla: {s["table"]} | Columna: {s["col"]} ({s["type"]})')
        print(f'ALTER TABLE "{s["table"]}" ADD PRIMARY KEY ("{s["col"]}");')
        print()

print("=" * 60)
