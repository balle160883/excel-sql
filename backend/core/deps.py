from fastapi import Depends, HTTPException, status
from fastapi.security import OAuth2PasswordBearer
import jwt
from jwt.exceptions import PyJWTError
from sqlalchemy.orm import Session
from database import get_db
from models.auth import User, UserPermission
from core.security import SECRET_KEY, ALGORITHM

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")

async def get_current_user(token: str = Depends(oauth2_scheme), db: Session = Depends(get_db)):
    credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Could not validate credentials",
        headers={"WWW-Authenticate": "Bearer"},
    )
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        username: str = payload.get("sub")
        if username is None:
            raise credentials_exception
    except PyJWTError:
        raise credentials_exception
        
    user = db.query(User).filter(User.username == username).first()
    if user is None:
        raise credentials_exception
    return user

async def get_current_active_user(current_user: User = Depends(get_current_user)):
    if not current_user.is_active:
        raise HTTPException(status_code=400, detail="Inactive user")
    return current_user

async def get_current_admin_user(current_user: User = Depends(get_current_active_user)):
    if not current_user.is_admin:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN, 
            detail="The user doesn't have enough privileges"
        )
    return current_user

class PermissionChecker:
    def __init__(self, table_name: str = None):
        self.table_name = table_name

    def __call__(self, current_user: User = Depends(get_current_active_user), db: Session = Depends(get_db)):
        if current_user.is_admin:
            return True
            
        if not self.table_name:
            return True

        perm = db.query(UserPermission).filter(
            UserPermission.user_id == current_user.id,
            UserPermission.table_name == self.table_name,
            UserPermission.can_edit == True
        ).first()
        
        if not perm:
            raise HTTPException(
                status_code=status.HTTP_403_FORBIDDEN, 
                detail=f"No tienes permisos para editar la tabla {self.table_name}"
            )
        return True
