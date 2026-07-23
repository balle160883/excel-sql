"use client";

import { useState, useEffect } from "react";
import { useAuth } from "@/context/AuthContext";
import DynamicForm from "./DynamicForm";
import { API_URL } from "@/lib/config";

export default function DataTable({ tableName }: { tableName: string }) {
    const { logout } = useAuth();
    const [data, setData] = useState<any[]>([]);
    const [columns, setColumns] = useState<string[]>([]);
    const [loading, setLoading] = useState(false);
    const [total, setTotal] = useState(0);
    const [primaryKey, setPrimaryKey] = useState<string>("");
    const [canEdit, setCanEdit] = useState(false);
    const [pkHasDefault, setPkHasDefault] = useState(false);

    // Estado para edición
    const [isEditing, setIsEditing] = useState(false);
    const [isNewRecord, setIsNewRecord] = useState(false);
    const [currentRecord, setCurrentRecord] = useState<any | null>(null);
    const [refreshTrigger, setRefreshTrigger] = useState(0);

    useEffect(() => {
        const fetchData = async () => {
            setLoading(true);
            try {
                const res = await fetch(`${API_URL}/tables/${tableName}`, {
                    headers: { "Authorization": `Bearer ${localStorage.getItem("sas_token")}` }
                });

                if (res.status === 401) {
                    logout();
                    return;
                }

                const result = await res.json();
                if (result.data) {
                    setData(result.data);
                    if (result.data.length > 0) {
                        setColumns(Object.keys(result.data[0]));
                    }
                    setTotal(result.total);
                    setPrimaryKey(result.primary_key || "id");
                    setPkHasDefault(result.pk_has_default || false);
                    setCanEdit(result.can_edit || false);
                }
            } catch (err) {
                console.error("Error loading data", err);
            } finally {
                setLoading(false);
            }
        };
        fetchData();
    }, [tableName, refreshTrigger]);

    const handleEdit = (record: any) => {
        setCurrentRecord(record);
        setIsNewRecord(false);
        setIsEditing(true);
    };

    const handleCreate = () => {
        // Objeto vacío con las columnas existentes (pero con valores null/vacíos)
        const emptyRecord = columns.reduce((acc, col) => ({ ...acc, [col]: "" }), {});
        setCurrentRecord(emptyRecord);
        setIsNewRecord(true);
        setIsEditing(true); // Reutilizamos el modal de edición
    };

    const handleSave = async (updatedData: any) => {
        if (!primaryKey) return;

        const pkValue = updatedData[primaryKey];
        // Determinar si es creación usando el estado real del formulario
        const isNew = isNewRecord;
        const url = isNew
            ? `${API_URL}/tables/${tableName}`
            : `${API_URL}/tables/${tableName}/${pkValue}`;

        const method = isNew ? 'POST' : 'PUT';

        try {
            const res = await fetch(url, {
                method: method,
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': `Bearer ${localStorage.getItem("sas_token")}`
                },
                body: JSON.stringify(updatedData)
            });

            const result = await res.json();

            if (result.status === 'success') {
                setIsEditing(false);
                setRefreshTrigger(prev => prev + 1);
            } else {
                alert(`Error al guardar: ${result.message}`);
            }
        } catch (err) {
            console.error("Error saving record", err);
            alert("Error de conexión al guardar");
        }
    };

    const handleDelete = async (record: any) => {
        if (!primaryKey) return;
        const pkValue = record[primaryKey];

        if (pkValue === undefined || pkValue === null || pkValue === "") {
            alert(`No se puede eliminar: la clave primaria '${primaryKey}' no tiene valor en este registro.`);
            return;
        }

        if (!confirm(`¿Estás seguro de que deseas eliminar el registro #${pkValue}? Esta acción se registrará en el log de auditoría.`)) {
            return;
        }

        try {
            const res = await fetch(`${API_URL}/tables/${tableName}/${pkValue}`, {
                method: 'DELETE',
                headers: {
                    'Authorization': `Bearer ${localStorage.getItem("sas_token")}`
                }
            });

            const result = await res.json();

            if (result.status === 'success') {
                setRefreshTrigger(prev => prev + 1);
            } else {
                alert(`Error al eliminar: ${result.message}`);
            }
        } catch (err) {
            console.error("Error deleting record", err);
            alert("Error de conexión al eliminar");
        }
    };

    if (loading && !data.length) {
        return (
            <div className="flex flex-col items-center justify-center h-64 gap-3">
                <div className="w-8 h-8 border-2 border-indigo-500/20 border-t-indigo-500 rounded-full animate-spin" />
                <p className="text-indigo-400/60 text-sm animate-pulse font-medium">Sincronizando registros...</p>
            </div>
        );
    }

    return (
        <div className="space-y-6 animate-lux">
            <div className="flex flex-col md:flex-row justify-between items-start md:items-center gap-4">
                <div className="flex flex-col gap-1">
                    <p className="text-xs text-slate-500 font-semibold uppercase tracking-wider">Métricas de Tabla</p>
                    <div className="flex items-center gap-2">
                        <span className="text-2xl font-bold text-white">{total.toLocaleString()}</span>
                        <span className="text-xs text-slate-400 bg-white/5 px-2 py-0.5 rounded-full border border-white/10 uppercase tracking-tighter">Registros Totales</span>
                    </div>
                </div>

                <div className="flex items-center gap-3">
                    {canEdit && (
                        <button
                            onClick={handleCreate}
                            className="text-xs font-bold uppercase bg-purple-600 hover:bg-purple-500 text-white px-4 py-2 rounded-xl transition-all shadow-lg shadow-purple-500/20 active:scale-95 flex items-center gap-2"
                        >
                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="3"><line x1="12" y1="5" x2="12" y2="19"></line><line x1="5" y1="12" x2="19" y2="12"></line></svg>
                            Nuevo Registro
                        </button>
                    )}
                    <div className="flex flex-col items-end gap-1">
                        <span className="text-[10px] text-slate-500 font-bold uppercase tracking-widest">Active Endpoint</span>
                        <code className="text-[11px] bg-purple-500/10 text-purple-400 px-3 py-1 rounded-lg border border-purple-500/20 font-mono shadow-sm">
                            PUT /tables/{tableName}/:pk
                        </code>
                    </div>
                </div>
            </div>

            <div className="overflow-x-auto rounded-[1.5rem] border border-white/5 bg-black/40 custom-scrollbar shadow-inner">
                <table className="w-full text-left text-sm border-collapse min-w-[800px]">
                    <thead>
                        <tr className="bg-white/[0.02]">
                            <th className="px-6 py-5 font-bold text-slate-400 border-b border-white/5 uppercase tracking-widest text-[10px] w-24">
                                Acciones
                            </th>
                            {columns.map((col) => (
                                <th key={col} className="px-6 py-5 font-bold text-slate-400 border-b border-white/5 uppercase tracking-widest text-[10px] whitespace-nowrap">
                                    {col.replace(/_/g, ' ')}
                                </th>
                            ))}
                        </tr>
                    </thead>
                    <tbody className="divide-y divide-white/[0.03]">
                        {data.map((row, i) => (
                            <tr key={i} className="hover:bg-white/[0.03] transition-colors group">
                                <td className="px-6 py-4">
                                    {canEdit ? (
                                        <div className="flex items-center gap-2">
                                            <button
                                                onClick={() => handleEdit(row)}
                                                className="text-[10px] font-bold uppercase bg-white/5 hover:bg-purple-600 hover:text-white text-slate-300 px-3 py-1.5 rounded-lg border border-white/10 transition-all shadow-lg active:scale-95"
                                            >
                                                Editar
                                            </button>
                                            <button
                                                onClick={() => handleDelete(row)}
                                                className="text-[10px] font-bold uppercase bg-white/5 hover:bg-red-600 hover:text-white text-slate-300 px-3 py-1.5 rounded-lg border border-white/10 transition-all shadow-lg active:scale-95"
                                            >
                                                Eliminar
                                            </button>
                                        </div>
                                    ) : (
                                        <span className="text-[10px] font-bold uppercase text-slate-600 px-3 py-1.5 flex items-center gap-1 opacity-50 cursor-not-allowed">
                                            <svg width="10" height="10" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="3"><rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect><path d="M7 11V7a5 5 0 0 1 10 0v4"></path></svg>
                                            Bloqueado
                                        </span>
                                    )}
                                </td>
                                {columns.map((col) => (
                                    <td key={col} className="px-6 py-4 text-slate-400 font-medium whitespace-nowrap max-w-xs overflow-hidden text-ellipsis border-r border-white/[0.01] last:border-r-0">
                                        {row[col] === null ? <span className="text-slate-700 italic">null</span> : String(row[col])}
                                    </td>
                                ))}
                            </tr>
                        ))}
                    </tbody>
                </table>
            </div>

            {/* Modal Lux */}
            {isEditing && currentRecord && (
                <div className="fixed inset-0 z-[100] flex items-center justify-center p-4 md:p-8">
                    <div className="absolute inset-0 bg-black/80 backdrop-blur-xl" onClick={() => setIsEditing(false)} />
                    <div className="bg-[#0c0c14] border border-white/10 rounded-[2.5rem] shadow-2xl w-full max-w-4xl max-h-[90vh] overflow-hidden relative z-10 flex flex-col">
                        <div className="p-6 md:p-8 flex-shrink-0 border-b border-white/5">
                            <div className="flex justify-between items-start">
                                <div>
                                    <span className="text-xs font-bold text-purple-500 uppercase tracking-widest mb-2 block">Editor de Registros</span>
                                    <h3 className="text-2xl font-bold text-white tracking-tight">
                                        {isNewRecord ? (
                                            "Nuevo Registro"
                                        ) : (
                                            <>
                                                Modificando <span className="text-purple-400">#{currentRecord[primaryKey]}</span>
                                            </>
                                        )}
                                    </h3>
                                    <p className="text-slate-500 text-sm mt-1">Tabla: {tableName}</p>
                                </div>
                                <button
                                    onClick={() => setIsEditing(false)}
                                    className="p-2 hover:bg-white/5 rounded-full text-slate-400 hover:text-white transition-all ring-1 ring-white/10"
                                >
                                    <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M6 18L18 6M6 6l12 12" />
                                    </svg>
                                </button>
                            </div>
                        </div>

                        <div className="flex-1 overflow-y-auto custom-scrollbar p-6 md:p-8">
                            <DynamicForm
                                initialData={currentRecord}
                                columns={columns}
                                primaryKey={primaryKey}
                                isNew={isNewRecord}
                                pkHasDefault={pkHasDefault}
                                onSubmit={handleSave}
                                onCancel={() => setIsEditing(false)}
                            />
                        </div>
                    </div>
                </div>
            )}
        </div>
    );
}
