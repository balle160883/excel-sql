from sqlalchemy.orm import Session
from models.audit import AuditLog
from typing import Any, Dict, Optional

def log_action(
    db: Session, 
    user_id: Optional[int], 
    action: str, 
    table_name: str, 
    record_id: str, 
    details: Optional[Dict[str, Any]] = None
):
    """
    Registra una acción de auditoría en la base de datos.
    """
    audit_entry = AuditLog(
        user_id=user_id,
        action=action,
        table_name=table_name,
        record_id=record_id,
        details=details
    )
    db.add(audit_entry)
    db.commit()
    db.refresh(audit_entry)
    return audit_entry
