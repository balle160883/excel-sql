from pydantic import BaseModel
from typing import List, Optional

class UserPermissionBase(BaseModel):
    table_name: str
    can_edit: bool

class UserPermissionCreate(UserPermissionBase):
    pass

class UserPermissionOut(UserPermissionBase):
    id: int
    user_id: int

    class Config:
        from_attributes = True

class UserBase(BaseModel):
    username: str
    is_admin: bool = False
    is_active: bool = True

class UserCreate(UserBase):
    password: str

class UserOut(UserBase):
    id: int
    permissions: List[UserPermissionOut] = []

    class Config:
        from_attributes = True

class PermissionUpdate(BaseModel):
    permissions: List[UserPermissionCreate]
