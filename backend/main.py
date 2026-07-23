from fastapi import FastAPI, UploadFile, File, Query, Depends, BackgroundTasks
from fastapi.middleware.cors import CORSMiddleware
from sqlalchemy import text, inspect
from services.processor import FileProcessor
from database import engine, get_db, Base
from models.auth import User, UserPermission
from models.audit import AuditLog  # Asegurar que Base.metadata lo cree
from routes import auth, users, chatbot
from core.deps import get_current_active_user, PermissionChecker, get_current_user, get_current_admin_user
from core.security import get_password_hash
from services.audit_service import log_action
from sqlalchemy.orm import Session
import uvicorn
import os
import re
from typing import List, Dict, Any

Base.metadata.create_all(bind=engine)

app = FastAPI(title="NOVA DATA | Gestión de Datos Premium")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(auth.router)
app.include_router(users.router)
app.include_router(chatbot.router)

processor = FileProcessor()

def run_sql_restore():
    # Desactivado a petición del usuario para importación web rápida
    pass

@app.on_event("startup")
def create_initial_admin():
    with engine.begin() as conn:
        result = conn.execute(text("SELECT id FROM users WHERE username = 'admin'")).fetchone()
        if not result:
            hashed_pwd = get_password_hash("admin123")
            conn.execute(
                text("INSERT INTO users (username, hashed_password, is_admin, is_active) VALUES (:u, :p, :a, :ac)"),
                {"u": "admin", "p": hashed_pwd, "a": True, "ac": True}
            )

@app.post("/restore-database")
async def trigger_restore(background_tasks: BackgroundTasks, current_user: User = Depends(get_current_admin_user)):
    background_tasks.add_task(run_sql_restore)
    return {"status": "success", "message": "Restauración iniciada en segundo plano"}

@app.get("/")
async def root():
    return {"message": "SAS SQL Import API is runnings"}

@app.post("/upload")
async def upload_file(
    file: UploadFile = File(...), 
    current_user: User = Depends(get_current_active_user)
):
    content = await file.read()
    filename = file.filename
    
    if filename.endswith(('.xlsx', '.csv')):
        if filename.endswith('.xlsx'):
            sheets = processor.process_excel(content)
            imported_tables = []
            for sheet_name, df in sheets.items():
                t_name = processor.create_dynamic_table(df, sheet_name, engine)
                imported_tables.append({
                    "table": t_name,
                    "rows": len(df)
                })
            
            return {
                "status": "success",
                "type": "multi-structured",
                "tables": imported_tables
            }
        else:
            df = processor.process_csv(content, filename)
            table_name = processor.create_dynamic_table(df, filename, engine)
            return {
                "status": "success", 
                "type": "structured", 
                "table": table_name,
                "rows": len(df),
                "columns": list(df.columns)
            }
    
    return {"status": "error", "message": "Solo se soportan archivos Excel y CSV para importación SQL"}

@app.get("/tables")
async def list_tables(current_user: User = Depends(get_current_active_user)):
    with engine.connect() as conn:
        query = text("SELECT table_name FROM information_schema.tables WHERE table_schema = 'public' AND table_name NOT IN ('users', 'user_permissions')")
        result = conn.execute(query)
        tables = [row[0] for row in result]
        return {"tables": tables}

@app.get("/tables/{table_name}/schema")
async def get_table_schema(
    table_name: str,
    current_user: User = Depends(get_current_active_user)
):
    try:
        inspector = inspect(engine)
        if not inspector.has_table(table_name):
             return {"status": "error", "message": f"Table '{table_name}' not found"}

        columns = []
        for col in inspector.get_columns(table_name):
            columns.append({
                "name": col['name'],
                "type": str(col['type']),
                "primary_key": col.get('primary_key', False),
                "nullable": col.get('nullable', True)
            })
        
        return {
            "table": table_name,
            "columns": columns
        }
    except Exception as e:
        return {"status": "error", "message": str(e)}

@app.get("/tables/{table_name}")
async def get_table_data(
    table_name: str, 
    limit: int = 100, 
    offset: int = 0,
    current_user: User = Depends(get_current_active_user)
):
    try:
        with engine.connect() as conn:
            query = text(f'SELECT * FROM "{table_name}" LIMIT :limit OFFSET :offset')
            result = conn.execute(query, {"limit": limit, "offset": offset})
            
            rows = [dict(row._mapping) for row in result]
            
            count_query = text(f'SELECT COUNT(*) FROM "{table_name}"')
            total_count = conn.execute(count_query).scalar()
            
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
            
            pk_column = pk_result[0] if pk_result else None
            if not pk_column:
                fallback = conn.execute(text("""
                    SELECT column_name FROM information_schema.columns
                    WHERE table_name = :table_name AND table_schema = 'public'
                    ORDER BY ordinal_position LIMIT 1
                """), {"table_name": table_name}).fetchone()
                pk_column = fallback[0] if fallback else "id"

            pk_has_default = False
            default_check_query = text("""
                SELECT column_default 
                FROM information_schema.columns 
                WHERE table_name = :table_name 
                  AND column_name = :pk_column 
                  AND table_schema = 'public'
            """)
            default_res = conn.execute(default_check_query, {"table_name": table_name, "pk_column": pk_column}).fetchone()
            if default_res and default_res[0] is not None:
                pk_has_default = True

            can_edit = False
            if current_user.is_admin:
                can_edit = True
            else:
                 perm_check = conn.execute(text("SELECT 1 FROM user_permissions WHERE user_id = :uid AND table_name = :tn AND can_edit = true"), {"uid": current_user.id, "tn": table_name}).fetchone()
                 if perm_check:
                     can_edit = True

            return {
                "table": table_name,
                "data": rows,
                "total": total_count,
                "limit": limit,
                "offset": offset,
                "primary_key": pk_column,
                "pk_has_default": pk_has_default,
                "can_edit": can_edit
            }
    except Exception as e:
        return {"status": "error", "message": str(e)}

@app.put("/tables/{table_name}/{pk_value}")
async def update_row(
    table_name: str, 
    pk_value: str, 
    updates: Dict[str, Any],
    current_user: User = Depends(get_current_active_user),
    db: Session = Depends(get_db) 
):
    checker = PermissionChecker(table_name)
    checker(current_user, db)

    try:
        with engine.begin() as conn:
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
            
            if not pk_result:
                fallback = conn.execute(text("""
                    SELECT column_name FROM information_schema.columns
                    WHERE table_name = :table_name AND table_schema = 'public'
                    ORDER BY ordinal_position LIMIT 1
                """), {"table_name": table_name}).fetchone()
                if fallback:
                    pk_column = fallback[0]
                else:
                    return {"status": "error", "message": f"No se encontró Primary Key para la tabla {table_name}"}
            else:
                pk_column = pk_result[0]

            inspector = inspect(engine)
            columns_info = inspector.get_columns(table_name)
            col_types = {col['name']: str(col['type']).upper() for col in columns_info}

            set_clauses = []
            params = {"pk_value": pk_value}
            idx = 0
            
            for key, value in updates.items():
                if key == pk_column or key not in col_types:
                    continue
                
                if value is None or value == "":
                    col_type = col_types[key]
                    is_text = any(t in col_type for t in ('CHAR', 'TEXT', 'VARCHAR'))
                    if is_text and value == "":
                        pass
                    else:
                        value = None

                param_name = f"val_{idx}"
                set_clauses.append(f'"{key}" = :{param_name}')
                params[param_name] = value
                idx += 1
            
            if not set_clauses:
                return {"status": "warning", "message": "No hay campos para actualizar"}

            sql = f'UPDATE "{table_name}" SET {", ".join(set_clauses)} WHERE "{pk_column}" = :pk_value'
            result = conn.execute(text(sql), params)
            
            if result.rowcount == 0:
                return {"status": "error", "message": "Registro no encontrado"}
                
            log_action(
                db=db,
                user_id=current_user.id,
                action="UPDATE",
                table_name=table_name,
                record_id=str(pk_value),
                details=updates
            )

            return {"status": "success", "message": "Registro actualizado correctamente"}
            
    except Exception as e:
        return {"status": "error", "message": str(e)}

@app.delete("/tables/{table_name}/{pk_value}")
async def delete_row(
    table_name: str,
    pk_value: str,
    current_user: User = Depends(get_current_active_user),
    db: Session = Depends(get_db)
):
    checker = PermissionChecker(table_name)
    checker(current_user, db)

    try:
        with engine.begin() as conn:
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
            if pk_result:
                pk_column = pk_result[0]
            else:
                fallback = conn.execute(text("""
                    SELECT column_name FROM information_schema.columns
                    WHERE table_name = :table_name AND table_schema = 'public'
                    ORDER BY ordinal_position LIMIT 1
                """), {"table_name": table_name}).fetchone()
                pk_column = fallback[0] if fallback else "id"

            sql = f'DELETE FROM "{table_name}" WHERE "{pk_column}" = :pk_value'
            result = conn.execute(text(sql), {"pk_value": pk_value})

            if result.rowcount == 0:
                return {"status": "error", "message": "Registro no encontrado"}

            log_action(
                db=db,
                user_id=current_user.id,
                action="DELETE",
                table_name=table_name,
                record_id="DELETED",
                details={"info": "Registro eliminado"}
            )

            return {"status": "success", "message": "Registro eliminado correctamente"}
    except Exception as e:
        return {"status": "error", "message": str(e)}

@app.post("/tables/{table_name}")
async def create_row(
    table_name: str,
    data: Dict[str, Any],
    current_user: User = Depends(get_current_active_user),
    db: Session = Depends(get_db)
):
    checker = PermissionChecker(table_name)
    checker(current_user, db)

    try:
        with engine.begin() as conn:
            inspector = inspect(engine)
            columns_info = inspector.get_columns(table_name)
            
            col_types = {}
            col_nullables = {}
            col_has_default = {}
            for col in columns_info:
                name = col['name']
                col_types[name] = str(col['type']).upper()
                col_nullables[name] = col.get('nullable', True)
                col_has_default[name] = col.get('default') is not None

            columns = []
            placeholders = []
            params = {}
            idx = 0
            
            for key, value in data.items():
                if key not in col_types:
                    continue
                
                if value is None or value == "":
                    col_type = col_types[key]
                    is_text = any(t in col_type for t in ('CHAR', 'TEXT', 'VARCHAR'))
                    
                    if is_text and value == "":
                        pass
                    else:
                        if col_has_default[key] or not col_nullables[key]:
                            continue
                        else:
                            value = None

                columns.append(f'"{key}"')
                param_name = f"val_{idx}"
                placeholders.append(f":{param_name}")
                params[param_name] = value
                idx += 1

            if not columns:
                return {"status": "error", "message": "No hay datos para insertar"}

            sql = f'INSERT INTO "{table_name}" ({", ".join(columns)}) VALUES ({", ".join(placeholders)})'
            conn.execute(text(sql), params)

            log_action(
                db=db,
                user_id=current_user.id,
                action="CREATE",
                table_name=table_name,
                record_id="NUEVO",
                details=data
            )

            return {"status": "success", "message": "Registro creado correctamente"}
    except Exception as e:
        return {"status": "error", "message": str(e)}

@app.get("/audit-logs")
async def get_audit_logs(
    limit: int = 100,
    skip: int = 0,
    current_user: User = Depends(get_current_admin_user),
    db: Session = Depends(get_db)
):
    logs = db.query(AuditLog).order_by(AuditLog.timestamp.desc()).offset(skip).limit(limit).all()
    result = []
    for log in logs:
        user = db.query(User).filter(User.id == log.user_id).first()
        result.append({
            "id": log.id,
            "username": user.username if user else "Sistema/Desconocido",
            "action": log.action,
            "table_name": log.table_name,
            "record_id": log.record_id,
            "details": log.details,
            "timestamp": log.timestamp
        })
    return result

if __name__ == "__main__":
    uvicorn.run("main:app", host="0.0.0.0", port=8000, reload=True)
