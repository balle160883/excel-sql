from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from typing import List
from database import get_db
from models.auth import User, UserPermission
from schemas.auth import UserCreate, UserOut, PermissionUpdate
from core.deps import get_current_admin_user
from core.security import get_password_hash
from services.audit_service import log_action
from core.deps import get_current_user

router = APIRouter(
    prefix="/users",
    tags=["users"],
    dependencies=[Depends(get_current_admin_user)] # Protege todas las rutas para solo admins
)

@router.get("/", response_model=List[UserOut])
async def read_users(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    users = db.query(User).offset(skip).limit(limit).all()
    return users

@router.post("/", response_model=UserOut)
async def create_user(user: UserCreate, db: Session = Depends(get_db)):
    db_user = db.query(User).filter(User.username == user.username).first()
    if db_user:
        raise HTTPException(status_code=400, detail="Username already registered")
    
    hashed_password = get_password_hash(user.password)
    new_user = User(
        username=user.username,
        hashed_password=hashed_password,
        is_admin=user.is_admin,
        is_active=user.is_active
    )
    db.add(new_user)
    db.commit()
    db.refresh(new_user)
    return new_user

@router.put("/{user_id}/permissions", response_model=UserOut)
async def update_permissions(user_id: int, permission_update: PermissionUpdate, db: Session = Depends(get_db)):
    user = db.query(User).filter(User.id == user_id).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    
    # Limpiar permisos existentes (estrategia simple: borrar y recrear)
    db.query(UserPermission).filter(UserPermission.user_id == user_id).delete()
    
    for perm in permission_update.permissions:
        new_perm = UserPermission(
            user_id=user_id,
            table_name=perm.table_name,
            can_edit=perm.can_edit
        )
        db.add(new_perm)
    
    db.commit()
    db.refresh(user)
    return user

@router.delete("/{user_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_user(
    user_id: int, 
    db: Session = Depends(get_db),
    current_admin: User = Depends(get_current_user)
):
    # Buscar usuario
    user = db.query(User).filter(User.id == user_id).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    
    username_deleted = user.username

    # Eliminar permisos asociados
    db.query(UserPermission).filter(UserPermission.user_id == user_id).delete()
    
    # Eliminar usuario
    db.delete(user)
    db.commit()

    # REGISTRO DE AUDITORÍA
    log_action(
        db=db,
        user_id=current_admin.id,
        action="DELETE_USER",
        table_name="users",
        record_id=str(user_id),
        details={"username_deleted": username_deleted}
    )

    return None
