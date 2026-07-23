"""
Chatbot Integration Router
--------------------------
Endpoints para conectar un sistema chatbot externo a la API de NOVA DATA.

Estrategia de autenticación:
  - Opción A (recomendada para chatbots): API Key en el header X-API-Key
  - Opción B: Bearer Token JWT (mismo sistema que el resto de la app)

Este router implementa las dos opciones. Por defecto se usa la API Key.
La clave se guarda en la variable de entorno CHATBOT_API_KEY.
"""

import os
from fastapi import APIRouter, HTTPException, Header, Depends, Query
from sqlalchemy import text, inspect
from sqlalchemy.orm import Session
from database import engine, get_db
from models.auth import User, UserPermission
from core.deps import get_current_active_user
from typing import Optional, List, Dict, Any
from pydantic import BaseModel

router = APIRouter(prefix="/chatbot", tags=["chatbot"])

# -------------------------------------------------------------------
# Autenticación por API Key (para sistemas externos / chatbot)
# -------------------------------------------------------------------
CHATBOT_API_KEY = os.getenv("CHATBOT_API_KEY", "chatbot-secret-key-2024")

def verify_api_key(x_api_key: str = Header(..., alias="X-API-Key")):
    """
    Dependencia que verifica la API Key enviada en el header X-API-Key.
    El chatbot externo debe incluir este header en cada petición.
    """
    if x_api_key != CHATBOT_API_KEY:
        raise HTTPException(status_code=401, detail="API Key inválida")
    return x_api_key


# -------------------------------------------------------------------
# Schemas de entrada/salida
# -------------------------------------------------------------------
class ChatQuery(BaseModel):
    """Cuerpo de una consulta desde el chatbot."""
    table: str                          # Nombre de la tabla a consultar
    filters: Optional[Dict[str, Any]] = {}  # Filtros clave=valor (igualdad exacta)
    columns: Optional[List[str]] = []   # Columnas específicas a devolver (vacío = todas)
    limit: Optional[int] = 20           # Máx. filas a devolver
    offset: Optional[int] = 0

class ChatMessage(BaseModel):
    """Mensaje de texto libre enviado por el chatbot para buscar en una tabla."""
    table: str
    message: str          # Pregunta / texto libre
    limit: Optional[int] = 10


# -------------------------------------------------------------------
# 1. Listar tablas disponibles
# -------------------------------------------------------------------
@router.get(
    "/tables",
    summary="Listar tablas disponibles",
    description="Retorna la lista de tablas de datos disponibles en el sistema. "
                "El chatbot puede usar esto para saber sobre qué datos puede responder.",
)
async def chatbot_list_tables(api_key: str = Depends(verify_api_key)):
    """
    Retorna todas las tablas de datos públicas (excluye tablas internas del sistema).
    """
    with engine.connect() as conn:
        query = text(
            "SELECT table_name FROM information_schema.tables "
            "WHERE table_schema = 'public' "
            "AND table_name NOT IN ('users', 'user_permissions', 'audit_logs')"
        )
        result = conn.execute(query)
        tables = [row[0] for row in result]
    return {"tables": tables, "total": len(tables)}


# -------------------------------------------------------------------
# 2. Obtener esquema de una tabla
# -------------------------------------------------------------------
@router.get(
    "/tables/{table_name}/schema",
    summary="Schema de una tabla",
    description="Retorna las columnas y tipos de datos de una tabla. "
                "Útil para que el chatbot sepa qué campos puede filtrar o mostrar.",
)
async def chatbot_table_schema(
    table_name: str,
    api_key: str = Depends(verify_api_key),
):
    inspector = inspect(engine)
    if not inspector.has_table(table_name):
        raise HTTPException(status_code=404, detail=f"Tabla '{table_name}' no encontrada")

    columns = []
    for col in inspector.get_columns(table_name):
        columns.append({
            "name": col["name"],
            "type": str(col["type"]),
            "nullable": col.get("nullable", True),
        })
    return {"table": table_name, "columns": columns}


# -------------------------------------------------------------------
# 3. Consultar datos con filtros (consulta estructurada)
# -------------------------------------------------------------------
@router.post(
    "/query",
    summary="Consultar datos de una tabla con filtros",
    description="El chatbot envía en el body la tabla, los filtros y las columnas que necesita. "
                "Esta es la forma principal de obtener datos del sistema."
)
async def chatbot_query(
    payload: ChatQuery,
    api_key: str = Depends(verify_api_key),
):
    """
    Ejemplo de body:
    {
        "table": "empleados",
        "filters": {"departamento": "Ventas"},
        "columns": ["nombre", "puesto", "salario"],
        "limit": 10,
        "offset": 0
    }
    """
    table_name = payload.table

    # Verificar que la tabla existe y no es una tabla interna
    inspector = inspect(engine)
    if not inspector.has_table(table_name):
        raise HTTPException(status_code=404, detail=f"Tabla '{table_name}' no encontrada")

    PROTECTED_TABLES = {"users", "user_permissions", "audit_logs"}
    if table_name in PROTECTED_TABLES:
        raise HTTPException(status_code=403, detail="Acceso denegado a tabla del sistema")

    try:
        with engine.connect() as conn:
            # Construir SELECT con columnas específicas o todas
            if payload.columns:
                col_list = ", ".join(payload.columns)
            else:
                col_list = "*"

            # Construir cláusula WHERE con los filtros (solo igualdad exacta)
            where_clauses = []
            params: Dict[str, Any] = {"limit": payload.limit, "offset": payload.offset}

            for key, value in (payload.filters or {}).items():
                where_clauses.append(f"{key} = :{key}")
                params[key] = value

            where_sql = f"WHERE {' AND '.join(where_clauses)}" if where_clauses else ""

            sql = text(
                f"SELECT {col_list} FROM {table_name} {where_sql} "
                f"LIMIT :limit OFFSET :offset"
            )
            result = conn.execute(sql, params)
            rows = [dict(row._mapping) for row in result]

            # Conteo total con los mismos filtros
            count_sql = text(f"SELECT COUNT(*) FROM {table_name} {where_sql}")
            count_params = {k: v for k, v in params.items() if k not in ("limit", "offset")}
            total = conn.execute(count_sql, count_params).scalar()

        return {
            "table": table_name,
            "data": rows,
            "total": total,
            "limit": payload.limit,
            "offset": payload.offset,
        }
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error al consultar: {str(e)}")


# -------------------------------------------------------------------
# 4. Búsqueda de texto libre en una tabla (LIKE en columnas de texto)
# -------------------------------------------------------------------
@router.post(
    "/search",
    summary="Búsqueda de texto libre",
    description="Permite buscar un término en TODAS las columnas de tipo texto de una tabla. "
                "Ideal para cuando el usuario escribe algo como: '¿hay algún cliente que se llame García?'"
)
async def chatbot_search(
    payload: ChatMessage,
    api_key: str = Depends(verify_api_key),
):
    """
    Ejemplo de body:
    {
        "table": "clientes",
        "message": "García",
        "limit": 10
    }
    El sistema buscará 'García' en todas las columnas VARCHAR/TEXT de la tabla.
    """
    table_name = payload.table

    inspector = inspect(engine)
    if not inspector.has_table(table_name):
        raise HTTPException(status_code=404, detail=f"Tabla '{table_name}' no encontrada")

    PROTECTED_TABLES = {"users", "user_permissions", "audit_logs"}
    if table_name in PROTECTED_TABLES:
        raise HTTPException(status_code=403, detail="Acceso denegado a tabla del sistema")

    try:
        # Detectar columnas de texto
        text_columns = [
            col["name"] for col in inspector.get_columns(table_name)
            if "VARCHAR" in str(col["type"]).upper()
            or "TEXT" in str(col["type"]).upper()
            or "CHAR" in str(col["type"]).upper()
        ]

        if not text_columns:
            return {"table": table_name, "data": [], "message": "La tabla no tiene columnas de texto para buscar"}

        # Construir LIKE para cada columna de texto (usando comillas dobles para nombres con caracteres especiales)
        like_clauses = [f'CAST("{col}" AS TEXT) ILIKE :term' for col in text_columns]
        where_sql = "WHERE " + " OR ".join(like_clauses)

        with engine.connect() as conn:
            sql = text(f'SELECT * FROM "{table_name}" {where_sql} LIMIT :limit')
            result = conn.execute(sql, {"term": f"%{payload.message}%", "limit": payload.limit})
            rows = [dict(row._mapping) for row in result]

        return {
            "table": table_name,
            "search_term": payload.message,
            "searched_columns": text_columns,
            "data": rows,
            "found": len(rows),
        }
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error en búsqueda: {str(e)}")


# -------------------------------------------------------------------
# 5. Resumen / estadísticas de una tabla (para respuestas de tipo "¿cuántos…?")
# -------------------------------------------------------------------
@router.get(
    "/tables/{table_name}/summary",
    summary="Resumen estadístico de una tabla",
    description="Devuelve métricas básicas: total de registros y valores únicos por columna. "
                "Útil para responder preguntas como '¿cuántos empleados hay?'"
)
async def chatbot_table_summary(
    table_name: str,
    api_key: str = Depends(verify_api_key),
):
    inspector = inspect(engine)
    if not inspector.has_table(table_name):
        raise HTTPException(status_code=404, detail=f"Tabla '{table_name}' no encontrada")

    PROTECTED_TABLES = {"users", "user_permissions", "audit_logs"}
    if table_name in PROTECTED_TABLES:
        raise HTTPException(status_code=403, detail="Acceso denegado a tabla del sistema")

    try:
        with engine.connect() as conn:
            total = conn.execute(text(f"SELECT COUNT(*) FROM {table_name}")).scalar()

            columns_info = []
            for col in inspector.get_columns(table_name):
                col_name = col["name"]
                unique_count = conn.execute(
                    text(f"SELECT COUNT(DISTINCT {col_name}) FROM {table_name}")
                ).scalar()
                columns_info.append({
                    "column": col_name,
                    "type": str(col["type"]),
                    "unique_values": unique_count,
                })

        return {
            "table": table_name,
            "total_rows": total,
            "columns": columns_info,
        }
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error al generar resumen: {str(e)}")


# -------------------------------------------------------------------
# 6. Ping / health check del chatbot
# -------------------------------------------------------------------
@router.get(
    "/ping",
    summary="Health check",
    description="Verifica que la integración entre el chatbot y la API está activa.",
)
async def chatbot_ping(api_key: str = Depends(verify_api_key)):
    return {"status": "ok", "message": "Chatbot API conectada correctamente"}
