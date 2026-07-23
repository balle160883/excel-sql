"use client";

import { useState, useEffect, useCallback } from "react";
import { useRouter } from "next/navigation";
import { useAuth } from "@/context/AuthContext";
import FileUploader from "@/components/FileUploader";
import DataTable from "@/components/DataTable";
import { API_URL } from "@/lib/config";

export default function Home() {
  const { user, logout, isLoading: authLoading } = useAuth();
  const router = useRouter();
  const [fileData, setFileData] = useState<any>(null);
  const [tables, setTables] = useState<string[]>([]);
  const [selectedTable, setSelectedTable] = useState<string | null>(null);
  const [searchQuery, setSearchQuery] = useState("");
  const [isSidebarOpen, setIsSidebarOpen] = useState(false);

  useEffect(() => {
    if (!authLoading && !user) {
      router.push("/login");
    }
  }, [user, authLoading, router]);

  const fetchTables = useCallback(async () => {
    try {
      const res = await fetch(`${API_URL}/tables`, {
        headers: { "Authorization": `Bearer ${localStorage.getItem("sas_token")}` }
      });

      if (res.status === 401) {
        logout();
        return;
      }

      const data = await res.json();
      setTables(data.tables || []);
    } catch (err) {
      console.error("Error al obtener tablas", err);
    }
  }, [logout]);

  useEffect(() => {
    fetchTables();
  }, [fetchTables]);

  // Efecto de seguridad para desbloquear la interfaz si se queda en "Sincronizando"
  // después de una carga exitosa.
  useEffect(() => {
    if (fileData && !selectedTable && tables.length > 0) {
      // Si tenemos datos de archivo pero ninguna tabla seleccionada,
      // seleccionamos la primera tabla disponible de la lista general.
      setSelectedTable(tables[0]);
    }
  }, [fileData, selectedTable, tables]);

  const handleUploadSuccess = (data: any) => {
    setFileData(data);

    // Si el backend devolvió múltiples tablas (Excel), seleccionamos la primera por defecto
    if (data.type === "multi-structured" && data.tables && data.tables.length > 0) {
      setSelectedTable(data.tables[0].table);
    } else if (data.table) {
      // Caso normal (CSV o una sola tabla)
      setSelectedTable(data.table);
    }

    fetchTables();
  };

  const filteredTables = (tables || []).filter(t => t.toLowerCase().includes((searchQuery || "").toLowerCase()));

  if (authLoading || !user) {
    return null; // O un spinner bonito
  }

  return (
    <div className="flex min-h-screen bg-[#030303] text-slate-200 selection:bg-violet-500/30 font-sans antialiased">
      {/* Sidebar Lux Noir */}
      <aside className={`fixed inset-y-0 left-0 w-80 premium-glass z-50 transition-all duration-700 ease-in-out lg:translate-x-0 ${isSidebarOpen ? 'translate-x-0' : '-translate-x-full lg:flex'} flex flex-col border-r border-white/5`}>
        <div className="p-10">
          <div className="flex items-center gap-4 mb-2">
            <div className="w-12 h-12 rounded-[1.25rem] bg-gradient-to-br from-violet-600 to-indigo-700 flex items-center justify-center shadow-2xl shadow-violet-500/20 ring-1 ring-white/10 group transition-all duration-500 border border-white/10">
              <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="text-white drop-shadow-lg group-hover:scale-110 transition-transform">
                <path d="M4 7v10c0 2.21 3.58 4 8 4s8-1.79 8-4V7M4 7c0 2.21 3.58 4 8 4s8-1.79 8-4M4 7c0-2.21 3.58-4 8-4s8 1.79 8 4" />
              </svg>
            </div>
            <div>
              <h1 className="text-xl font-black tracking-tighter text-white leading-none">NOVA <span className="text-violet-400">DATA</span></h1>
              <span className="text-[10px] text-slate-500 font-bold uppercase tracking-[0.3em] mt-1.5 block opacity-60">Engine Core v2.0</span>
            </div>
          </div>
        </div>

        <div className="px-6 pb-6 flex-1 overflow-y-auto custom-scrollbar">
          <div className="relative mb-8 group">
            <div className="absolute inset-y-0 left-4 flex items-center pointer-events-none">
              <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" className="text-slate-600 group-focus-within:text-violet-500 transition-colors">
                <circle cx="11" cy="11" r="8" /><path d="m21 21-4.3-4.3" />
              </svg>
            </div>
            <input
              type="text"
              placeholder="Buscar tabla..."
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              className="w-full bg-white/[0.02] border border-white/5 rounded-2xl pl-12 pr-5 py-4 text-sm focus:outline-none focus:ring-2 focus:ring-violet-500/30 transition-all text-slate-300 placeholder:text-slate-700 outline-none"
            />
          </div>

          <nav className="space-y-2">
            <div className="flex items-center justify-between mb-4 px-4 text-[10px] font-bold uppercase tracking-[0.4em] text-slate-600">
              <span>LIBRERÍA SQL</span>
              <span className="bg-white/5 px-2 py-0.5 rounded text-[8px] border border-white/5">{filteredTables.length}</span>
            </div>
            {filteredTables.map((table) => (
              <button
                key={table}
                onClick={() => { setSelectedTable(table); setIsSidebarOpen(false); }}
                className={`w-full group flex items-center gap-4 px-5 py-4 rounded-2xl transition-all relative ${selectedTable === table
                  ? "bg-white/[0.03] text-white shadow-[0_10px_30px_-10px_rgba(0,0,0,0.5)] border border-white/10"
                  : "text-slate-500 hover:text-slate-200 hover:bg-white/[0.01]"
                  }`}
              >
                <div className={`p-2 rounded-xl transition-all flex items-center justify-center ${selectedTable === table ? "bg-violet-500/20 text-violet-400 border border-violet-500/20" : "bg-white/[0.02] text-slate-700 group-hover:text-slate-500 border border-transparent"}`}>
                  <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                    <path d="M3 10h18M3 14h18m-9-4v8m-7 0h14a2 2 0 002-2V8a2 2 0 00-2-2H5a2 2 0 00-2 2v8a2 2 0 002 2z" />
                  </svg>
                </div>
                <span className="text-sm font-bold truncate leading-none">{table}</span>
                {selectedTable === table && (
                  <span className="ml-auto w-1.5 h-1.5 rounded-full bg-violet-500 animate-pulse shadow-[0_0_12px_#8b5cf6]" />
                )}
              </button>
            ))}
            {filteredTables.length === 0 && (
              <div className="p-10 text-center opacity-40">
                <p className="text-[10px] font-bold uppercase tracking-widest text-slate-600">Base Vacía</p>
              </div>
            )}

          </nav>
        </div>

        <div className="p-8 border-t border-white/5 space-y-4">
          {user?.is_admin && (
            <button
              onClick={() => router.push("/admin")}
              className="w-full group flex items-center gap-4 px-4 py-3 rounded-2xl transition-all border border-violet-500/20 bg-violet-500/5 hover:bg-violet-500/10 text-violet-300"
            >
              <div className="w-10 h-10 rounded-xl bg-violet-500/20 text-violet-400 flex items-center justify-center border border-violet-500/20">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                  <path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z" />
                </svg>
              </div>
              <div className="flex flex-col items-start">
                <span className="text-xs font-bold truncate leading-none">Gestión Usuarios</span>
                <span className="text-[9px] text-violet-400/60 font-bold uppercase tracking-widest mt-1">Panel Admin</span>
              </div>
            </button>
          )}
          <div className="flex items-center gap-4 px-4 py-3 rounded-2xl bg-white/[0.02] border border-white/5 group hover:bg-white/[0.04] transition-all">
            <div className="w-10 h-10 rounded-xl bg-violet-600/20 flex items-center justify-center text-violet-400 font-bold border border-violet-500/20">
              {user?.username?.[0]?.toUpperCase() || 'U'}
            </div>
            <div className="flex flex-col flex-1 overflow-hidden">
              <span className="text-xs text-white font-black truncate">{user?.username}</span>
              <span className="text-[9px] text-slate-500 font-bold uppercase tracking-widest">{user?.is_admin ? 'Administrador' : 'Usuario'}</span>
            </div>
            <button
              onClick={() => logout()}
              className="p-2 text-slate-600 hover:text-red-400 transition-colors"
              title="Cerrar Sesión"
            >
              <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M9 21H5a2 2 0 01-2-2V5a2 2 0 012-2h4M16 17l5-5-5-5M21 12H9" /></svg>
            </button>
          </div>

          <div className="flex items-center gap-4 px-4 py-3 rounded-2xl bg-emerald-500/5 border border-emerald-500/10">
            <div className="relative flex h-2 w-2">
              <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-emerald-400 opacity-75"></span>
              <span className="relative inline-flex rounded-full h-2 w-2 bg-emerald-500"></span>
            </div>
            <div className="flex flex-col gap-0.5">
              <span className="text-[10px] text-white font-black uppercase tracking-widest leading-none">PostgreSQL OK</span>
              <span className="text-[8px] text-emerald-500/60 font-medium uppercase tracking-widest leading-none">Sync Activo</span>
            </div>
          </div>
        </div>
      </aside>

      {/* Main Viewport Lux Noir */}
      <main className="flex-1 lg:ml-80 min-h-screen relative flex flex-col items-center">
        {/* Superior Header */}
        <header className="sticky top-0 w-full p-8 lg:px-12 z-40 bg-[#030303]/70 backdrop-blur-3xl border-b border-white/5 flex items-center justify-between">
          <div className="flex items-center gap-6 animate-lux">
            <button onClick={() => setIsSidebarOpen(true)} className="lg:hidden p-3 premium-glass rounded-2xl border border-white/10 hover:bg-white/5 transition-colors">
              <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><path d="M4 6h16M4 12h16M4 18h16" /></svg>
            </button>
            <div className="flex flex-col gap-1">
              <div className="flex items-center gap-2">
                <span className="w-1.5 h-1.5 rounded-full bg-violet-500" />
                <p className="text-[9px] text-violet-400 font-black uppercase tracking-[0.4em]">Visualización de Datos</p>
              </div>
              <h2 className="text-3xl font-black text-white tracking-tighter leading-none">
                {selectedTable ? <span className="lux-gradient">{selectedTable}</span> : <span className="lux-gradient">Panel Central</span>}
              </h2>
            </div>
          </div>

          <button
            onClick={() => { setSelectedTable(null); setFileData(null); }}
            className="lux-button px-8 py-4 text-[10px] font-black uppercase tracking-[0.2em] text-white shadow-[0_20px_40px_-15px_rgba(139,92,246,0.3)] hover:border-violet-500/50 transition-all"
          >
            Nueva Ingesta
          </button>
        </header>

        {/* Dynamic Content Area */}
        <div className="flex-1 w-full p-8 lg:p-16 max-w-[1600px] flex flex-col">
          {!selectedTable && !fileData ? (
            <div className="flex-1 flex flex-col items-center justify-center py-10 animate-lux">
              <div className="grid lg:grid-cols-2 gap-20 items-center w-full max-w-6xl">
                <div className="space-y-10 text-center lg:text-left">
                  <div className="inline-flex items-center gap-3 px-6 py-2.5 rounded-full bg-white/[0.02] border border-white/5 text-[10px] font-black text-slate-500 uppercase tracking-[0.3em] backdrop-blur-md">
                    <span className="text-violet-500 text-base">✦</span>
                    Sistema Lux Noir Desplegado
                  </div>
                  <h3 className="text-7xl md:text-9xl font-black text-white leading-[0.85] tracking-tighter">
                    Datos <br />
                    <span className="lux-accent-gradient drop-shadow-2xl">Puros.</span>
                  </h3>
                  <p className="text-xl text-slate-500 font-medium leading-relaxed max-w-md mx-auto lg:mx-0 opacity-80">
                    Sincronización profesional entre Excel y SQL con una arquitectura diseñada para la velocidad y el impacto visual.
                  </p>

                  <div className="flex flex-wrap gap-8 justify-center lg:justify-start pt-4">
                    <div className="flex items-center gap-4">
                      <div className="w-12 h-12 rounded-2xl bg-white/[0.03] border border-white/5 flex items-center justify-center text-white">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z" /></svg>
                      </div>
                      <div className="text-left">
                        <p className="text-xl font-black text-white tracking-tighter">100%</p>
                        <p className="text-[9px] text-slate-600 font-bold uppercase tracking-widest">Cifrado</p>
                      </div>
                    </div>
                    <div className="flex items-center gap-4">
                      <div className="w-12 h-12 rounded-2xl bg-white/[0.03] border border-white/5 flex items-center justify-center text-white">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><path d="M13 2L3 14h9l-1 8 10-12h-9l1-8z" /></svg>
                      </div>
                      <div className="text-left">
                        <p className="text-xl font-black text-white tracking-tighter">&lt; 1s</p>
                        <p className="text-[9px] text-slate-600 font-bold uppercase tracking-widest">Sync</p>
                      </div>
                    </div>
                  </div>
                </div>

                <div className="relative group">
                  <div className="absolute -inset-4 bg-violet-600/10 blur-[100px] rounded-full opacity-0 group-hover:opacity-100 transition-opacity duration-1000 -z-10" />
                  <FileUploader onUploadSuccess={handleUploadSuccess} />
                </div>
              </div>
            </div>
          ) : (
            <div className="animate-lux w-full h-full flex flex-col">
              {selectedTable ? (
                <div className="lux-card border border-white/5 shadow-[0_40px_100px_-30px_rgba(0,0,0,0.8)] relative overflow-hidden flex-1 flex flex-col">
                  <div className="absolute -top-40 -right-40 w-[600px] h-[600px] bg-violet-600/5 blur-[150px] -z-10 rounded-full animate-pulse" />
                  <DataTable tableName={selectedTable} />
                </div>
              ) : (
                <div className="flex-1 flex flex-col items-center justify-center lux-card gap-10 border border-white/5">
                  <div className="relative">
                    <div className="absolute inset-0 bg-violet-500/20 blur-3xl rounded-full" />
                    <div className="w-24 h-24 border-2 border-violet-500/10 border-t-violet-500 rounded-full animate-spin relative z-10" />
                  </div>
                  <div className="text-center space-y-3">
                    <p className="text-2xl font-black text-white tracking-tighter">Sincronizando con PostgreSQL</p>
                    <p className="text-slate-600 text-[10px] font-black uppercase tracking-[0.5em]">Construyendo Estructura Relacional</p>
                  </div>
                </div>
              )}
            </div>
          )}
        </div>
      </main>
    </div>
  );
}
