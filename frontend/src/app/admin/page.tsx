"use client";

import { useState, useEffect } from "react";
import { useRouter } from "next/navigation";
import { useAuth } from "@/context/AuthContext";
import { API_URL } from "@/lib/config";

interface User {
    id: number;
    username: string;
    is_admin: boolean;
    is_active: boolean;
    permissions: { table_name: string; can_edit: boolean }[];
}

export default function AdminPage() {
    const { user: currentUser, isLoading: authLoading } = useAuth();
    const router = useRouter();
    const [users, setUsers] = useState<User[]>([]);
    const [tables, setTables] = useState<string[]>([]);

    // Form states
    const [newUsername, setNewUsername] = useState("");
    const [newPassword, setNewPassword] = useState("");
    const [isAdmin, setIsAdmin] = useState(false);

    // Permission management
    const [selectedUser, setSelectedUser] = useState<User | null>(null);
    const [selectedPermissions, setSelectedPermissions] = useState<string[]>([]);

    const [isLoading, setIsLoading] = useState(false);
    const [message, setMessage] = useState("");

    useEffect(() => {
        if (!authLoading && (!currentUser || !currentUser.is_admin)) {
            router.push("/");
        } else if (currentUser?.is_admin) {
            fetchUsers();
            fetchTables();
        }
    }, [currentUser, authLoading, router]);

    const fetchUsers = async () => {
        try {
            const res = await fetch(`${API_URL}/users/`, {
                headers: { "Authorization": `Bearer ${localStorage.getItem("sas_token")}` }
            });
            if (res.ok) setUsers(await res.json());
        } catch (err) {
            console.error(err);
        }
    };

    const fetchTables = async () => {
        try {
            const res = await fetch(`${API_URL}/tables`, {
                headers: { "Authorization": `Bearer ${localStorage.getItem("sas_token")}` }
            });
            const data = await res.json();
            setTables(data.tables || []);
        } catch (err) {
            console.error(err);
        }
    };

    const handleCreateUser = async (e: React.FormEvent) => {
        e.preventDefault();
        setIsLoading(true);
        setMessage("");

        try {
            const res = await fetch(`${API_URL}/users/`, {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                    "Authorization": `Bearer ${localStorage.getItem("sas_token")}`
                },
                body: JSON.stringify({
                    username: newUsername,
                    password: newPassword,
                    is_admin: isAdmin,
                    is_active: true
                })
            });

            if (!res.ok) throw new Error("Error al crear usuario");

            setNewUsername("");
            setNewPassword("");
            fetchUsers();
            setMessage("Usuario creado correctamente");
        } catch (err) {
            setMessage("Error creando usuario");
        } finally {
            setIsLoading(false);
        }
    };

    const openPermissionModal = (user: User) => {
        setSelectedUser(user);
        // Pre-select tables where user has edit permission
        const perms = user.permissions?.filter(p => p.can_edit).map(p => p.table_name) || [];
        setSelectedPermissions(perms);
    };

    const handleUpdatePermissions = async () => {
        if (!selectedUser) return;

        const permsPayload = selectedPermissions.map(table => ({
            table_name: table,
            can_edit: true
        }));

        try {
            const res = await fetch(`${API_URL}/users/${selectedUser.id}/permissions`, {
                method: "PUT",
                headers: {
                    "Content-Type": "application/json",
                    "Authorization": `Bearer ${localStorage.getItem("sas_token")}`
                },
                body: JSON.stringify({ permissions: permsPayload })
            });

            if (res.ok) {
                setSelectedUser(null);
                fetchUsers();
            }
        } catch (err) {
            console.error(err);
        }
    };

    const togglePermission = (tableName: string) => {
        if (selectedPermissions.includes(tableName)) {
            setSelectedPermissions(selectedPermissions.filter(t => t !== tableName));
        } else {
            setSelectedPermissions([...selectedPermissions, tableName]);
        }
    };

    const handleDeleteUser = async (user: User) => {
        if (!confirm(`¿Estás seguro de eliminar al usuario "${user.username}"? Esta acción no se puede deshacer.`)) {
            return;
        }

        try {
            const res = await fetch(`${API_URL}/users/${user.id}`, {
                method: "DELETE",
                headers: {
                    "Authorization": `Bearer ${localStorage.getItem("sas_token")}`
                }
            });

            if (res.ok) {
                fetchUsers();
                setMessage("Usuario eliminado correctamente");
            } else {
                setMessage("Error al eliminar usuario");
            }
        } catch (err) {
            console.error(err);
            setMessage("Error de conexión");
        }
    };

    if (authLoading || !currentUser?.is_admin) return null;

    return (
        <div className="min-h-screen bg-[#030303] text-white p-8 lg:p-12 font-sans">
            <header className="mb-12 flex items-center justify-between">
                <div>
                    <h1 className="text-3xl font-black tracking-tighter text-white">Administración de <span className="text-violet-400">Usuarios</span></h1>
                    <p className="text-slate-500 text-[10px] font-bold uppercase tracking-widest mt-1">Control de Accesos RBAC</p>
                </div>
                <button onClick={() => router.push("/")} className="text-sm font-bold text-slate-400 hover:text-white transition-colors">
                    ← Volver al Dashboard
                </button>
            </header>

            <div className="grid lg:grid-cols-3 gap-12">
                {/* Create User Form */}
                <div className="lg:col-span-1">
                    <div className="lux-card space-y-6 sticky top-8">
                        <h2 className="text-xl font-bold tracking-tight">Nuevo Usuario</h2>
                        <form onSubmit={handleCreateUser} className="space-y-4">
                            <div>
                                <label className="text-[9px] uppercase font-bold text-slate-500 block mb-1">Username</label>
                                <input
                                    type="text"
                                    value={newUsername}
                                    onChange={e => setNewUsername(e.target.value)}
                                    className="w-full bg-white/[0.03] border border-white/10 rounded-xl px-4 py-2 text-sm focus:outline-none focus:border-violet-500/50"
                                    required
                                />
                            </div>
                            <div>
                                <label className="text-[9px] uppercase font-bold text-slate-500 block mb-1">Password</label>
                                <input
                                    type="password"
                                    value={newPassword}
                                    onChange={e => setNewPassword(e.target.value)}
                                    className="w-full bg-white/[0.03] border border-white/10 rounded-xl px-4 py-2 text-sm focus:outline-none focus:border-violet-500/50"
                                    required
                                />
                            </div>
                            <div className="flex items-center gap-3 py-2">
                                <div
                                    onClick={() => setIsAdmin(!isAdmin)}
                                    className={`w-10 h-6 rounded-full p-1 cursor-pointer transition-colors ${isAdmin ? 'bg-violet-600' : 'bg-slate-700'}`}
                                >
                                    <div className={`w-4 h-4 bg-white rounded-full shadow-md transform transition-transform ${isAdmin ? 'translate-x-4' : ''}`} />
                                </div>
                                <span className="text-sm font-medium">Es Administrador</span>
                            </div>

                            <button disabled={isLoading} className="w-full py-3 rounded-xl font-bold uppercase tracking-widest text-[10px] transition-all bg-violet-600 hover:bg-violet-500 text-white shadow-[0_0_20px_-5px_rgba(124,58,237,0.5)]">
                                {isLoading ? "Creando..." : "Crear Usuario"}
                            </button>
                            {message && <p className="text-xs text-center text-emerald-400 font-bold">{message}</p>}
                        </form>
                    </div>
                </div>

                {/* User List */}
                <div className="lg:col-span-2 space-y-6">
                    {users.map(user => (
                        <div key={user.id} className="premium-glass p-6 rounded-3xl border border-white/5 flex items-center justify-between">
                            <div className="flex items-center gap-4">
                                <div className={`w-10 h-10 rounded-full flex items-center justify-center font-bold text-lg ${user.is_admin ? 'bg-violet-500 text-white' : 'bg-slate-800 text-slate-400'}`}>
                                    {user.username[0].toUpperCase()}
                                </div>
                                <div>
                                    <h3 className="font-bold text-lg leading-none">{user.username}</h3>
                                    <div className="flex gap-2 mt-1">
                                        <span className={`text-[9px] px-2 py-0.5 rounded-full font-bold uppercase tracking-widest ${user.is_admin ? 'bg-violet-500/20 text-violet-300' : 'bg-slate-500/10 text-slate-500'}`}>
                                            {user.is_admin ? 'Admin' : 'Usuario'}
                                        </span>
                                        <span className="text-[9px] px-2 py-0.5 rounded-full bg-emerald-500/10 text-emerald-500 font-bold uppercase tracking-widest">Activo</span>
                                    </div>
                                </div>
                            </div>

                            <div className="flex gap-2">
                                <button
                                    onClick={() => openPermissionModal(user)}
                                    className="px-4 py-2 rounded-xl bg-white/[0.05] hover:bg-white/[0.1] text-xs font-bold transition-colors border border-white/5"
                                >
                                    Gestionar Permisos ({user.permissions?.length || 0})
                                </button>
                                <button
                                    onClick={() => handleDeleteUser(user)}
                                    className="px-4 py-2 rounded-xl bg-red-500/10 hover:bg-red-500/20 text-red-400 hover:text-red-300 text-xs font-bold transition-colors border border-red-500/10"
                                >
                                    Eliminar
                                </button>
                            </div>
                        </div>
                    ))}
                </div>
            </div>

            {/* Permission Modal */}
            {selectedUser && (
                <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/80 backdrop-blur-sm">
                    <div className="lux-card w-full max-w-2xl max-h-[80vh] flex flex-col animate-lux">
                        <div className="flex items-center justify-between mb-6">
                            <div>
                                <h3 className="text-2xl font-bold">Permisos de Edición</h3>
                                <p className="text-slate-500 text-sm">Usuario: <span className="text-white font-bold">{selectedUser.username}</span></p>
                            </div>
                            <button onClick={() => setSelectedUser(null)} className="p-2 hover:bg-white/10 rounded-full">✕</button>
                        </div>

                        <div className="flex-1 overflow-y-auto custom-scrollbar p-2 -mx-2">
                            <div className="grid grid-cols-2 gap-3">
                                {tables.map(table => (
                                    <label key={table} className={`flex items-center gap-3 p-4 rounded-xl border cursor-pointer transition-all ${selectedPermissions.includes(table) ? 'bg-violet-600/20 border-violet-500/50' : 'bg-white/[0.02] border-white/5 hover:border-white/10'}`}>
                                        <div className={`w-5 h-5 rounded flex items-center justify-center border ${selectedPermissions.includes(table) ? 'bg-violet-500 border-violet-500' : 'border-slate-600'}`}>
                                            {selectedPermissions.includes(table) && <svg width="12" height="12" viewBox="0 0 24 24" stroke="currentColor" strokeWidth="4"><path d="M20 6L9 17l-5-5" /></svg>}
                                        </div>
                                        <input type="checkbox" className="hidden" checked={selectedPermissions.includes(table)} onChange={() => togglePermission(table)} />
                                        <span className="text-sm font-medium truncate">{table}</span>
                                    </label>
                                ))}
                            </div>
                        </div>

                        <div className="mt-8 flex justify-end gap-4 pt-4 border-t border-white/5">
                            <button onClick={() => setSelectedUser(null)} className="px-6 py-3 rounded-xl hover:bg-white/5 text-sm font-bold">Cancelar</button>
                            <button onClick={handleUpdatePermissions} className="px-8 py-3 rounded-xl bg-white text-black text-sm font-bold uppercase tracking-widest hover:bg-slate-200">
                                Guardar Cambios
                            </button>
                        </div>
                    </div>
                </div>
            )}
        </div>
    );
}
