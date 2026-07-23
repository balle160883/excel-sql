import psycopg2

try:
    conn = psycopg2.connect(
        host='sas_db',
        port=5432,
        database='sas_db',
        user='postgres',
        password='postgres'
    )
    cur = conn.cursor()
    cur.execute("""
        SELECT column_name, column_default, is_nullable, data_type
        FROM information_schema.columns
        WHERE table_name = 'tramites_y_servicios'
    """)
    cols = cur.fetchall()
    for col in cols:
        print(col)
except Exception as e:
    print("Error:", e)
