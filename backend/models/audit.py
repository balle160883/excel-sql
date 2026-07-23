from sqlalchemy import Column, Integer, String, DateTime, JSON, ForeignKey
from sqlalchemy.sql import func
from database import Base

class AuditLog(Base):
    __tablename__ = "audit_logs"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=True)
    action = Column(String)  # 'UPDATE', 'DELETE', 'CREATE', etc.
    table_name = Column(String)
    record_id = Column(String)  # ID del registro afectado (como string por flexibilidad)
    details = Column(JSON, nullable=True)  # Cambios realizados o contexto adicional
    timestamp = Column(DateTime(timezone=True), server_default=func.now())
