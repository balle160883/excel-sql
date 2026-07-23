# Manual Técnico: API NOVA DATA (Excel a SQL)

Este documento proporciona una guía técnica detallada para el uso e integración con la API de NOVA DATA. El sistema está diseñado para transformar archivos Excel y CSV en bases de datos PostgreSQL dinámicas y facilitar su consulta mediante una interfaz administrativa y un chatbot.

---

## 🏗️ Arquitectura del Sistema

El sistema utiliza un stack moderno y escalable:

*   **Backend**: FastAPI (Python 3.10+)
*   **Base de Datos**: PostgreSQL
*   **ORM**: SQLAlchemy & Alembic
*   **Contenerización**: Docker & Docker Compose
*   **Proxy Seguro**: Cloudflare Tunnel (para exposición externa sin IP pública)

### Flujo de Datos
1.  **Importación**: Los archivos son procesados por `FileProcessor`, que crea tablas dinámicas basadas en las cabeceras del archivo.
2.  **Consulta**: Los datos se exponen mediante endpoints REST que permiten paginación, filtros y búsqueda.
3.  **Auditoría**: Cada acción de escritura (Create, Update, Delete) se registra en una tabla de auditoría con la identidad del usuario.

---

## 🔐 Seguridad y Autenticación

La API implementa dos capas de seguridad dependiendo del tipo de cliente:

### 1. Autenticación Administrativa (JWT)
Utilizada por el Panel Web de administración. Utiliza tokens portadores (Bearer Tokens).
*   **Token**: JWT (JSON Web Token)
*   **Algoritmo**: HS256
*   **Expiración**: 30 minutos (configurable)
*   **Formato de Header**: `Authorization: Bearer <TU_TOKEN>`

### 2. Autenticación para Integración (API Key)
Utilizada por sistemas externos como Chatbots para evitar la gestión de sesiones JWT.
*   **Header**: `X-API-Key`
*   **Valor**: Definido en la variable `CHATBOT_API_KEY` del archivo `.env`.
*   **Valor por defecto**: `chatbot-secret-key-2024`

---

## 📂 Endpoints de Gestión de Datos

### 1. Importación de Archivos
Permite cargar un archivo para crear o actualizar tablas en la base de datos.
*   **URL**: `POST /upload`
*   **Auth**: Requiere Token JWT
*   **Form-Data**: `file` (archivo .xlsx o .csv)
*   **Respuesta**: Detalle de tablas creadas y número de filas procesadas.

### 2. Inventario de Tablas
Lista las tablas disponibles para consulta que no son de sistema.
*   **URL**: `GET /tables`
*   **Auth**: Requiere Token JWT

---

## 🔄 Operaciones CRUD Dinámicas

Estos endpoints funcionan para **cualquier** tabla importada en el sistema.

### Listar Datos de una Tabla
*   **URL**: `GET /tables/{table_name}`
*   **Params**: `limit` (default 100), `offset` (default 0)
*   **Respuesta**: Objeto con los datos de las filas, total de registros y metadatos de permisos.

### Actualizar un Registro
*   **URL**: `PUT /tables/{table_name}/{pk_value}`
*   **Body**: JSON con los campos a modificar.
*   **Ejemplo**: `{"nombre": "Nuevo Nombre", "edad": 25}`

---

## 🤖 API de Integración (Chatbot)

Ubicada bajo el prefijo `/chatbot`, optimizada para ser consumida por asistentes de IA.

### Búsqueda Inteligente
Busca un término en **todas** las columnas de texto de una tabla seleccionada.
*   **URL**: `POST /chatbot/search`
*   **Auth**: `X-API-Key`
*   **Cuerpo (JSON)**:
    ```json
    {
      "table": "mi_tabla_de_productos",
      "message": "término de búsqueda",
      "limit": 5
    }
    ```

### Resumen de Tabla
Obtiene estadísticas rápidas para que el chatbot pueda responder preguntas tipo "¿cuántos?".
*   **URL**: `GET /chatbot/tables/{table_name}/summary`
*   **Respuesta**: Total de filas y conteo de valores únicos por columna.

---

## 📝 Auditoría

El sistema registra automáticamente en la tabla `audit_logs`:
*   Usuario que realizó la acción.
*   Acción (CREATE, UPDATE, DELETE).
*   Tabla y ID del registro afectado.
*   Detalle de los datos (JSON).
*   Marca de tiempo (Timestamp).

Para consultar los logs (Solo Admin): `GET /audit-logs`

---

> [!TIP]
> **Swagger UI**: Puedes acceder a la documentación interactiva generada por FastAPI en `http://localhost:8000/docs` para probar cada endpoint en tiempo real.
