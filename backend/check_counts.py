
from sqlalchemy import create_engine, text, inspect
import os

DATABASE_URL = "postgresql://postgres:postgres@sas_db:5432/sas_db"
engine = create_engine(DATABASE_URL)

def list_and_count():
    inspector = inspect(engine)
    tables = inspector.get_table_names()
    print(f"{'Table':<40} | {'Count':<10}")
    print("-" * 55)
    
    for table in sorted(tables):
        if table in ['users', 'user_permissions', 'audit_logs']:
            continue
        try:
            with engine.connect() as conn:
                res = conn.execute(text(f'SELECT COUNT(*) FROM "{table}"'))
                count = res.scalar()
                print(f"{table:<40} | {count:<10}")
        except Exception as e:
            print(f"{table:<40} | Error: {e}")

if __name__ == "__main__":
    list_and_count()
