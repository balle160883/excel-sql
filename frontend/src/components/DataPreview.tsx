"use client";

export default function DataPreview({ data }: { data: any }) {
    if (data.type === "unstructured") {
        return (
            <div className="flex flex-col items-center justify-center h-full text-center space-y-4">
                <div className="w-16 h-16 bg-white/5 rounded-full flex items-center justify-center text-amber-400">
                    <svg className="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                    </svg>
                </div>
                <p className="text-white/60">Archivo de texto detectado.</p>
                <p className="text-sm text-indigo-400 bg-indigo-500/10 px-3 py-1 rounded-full border border-indigo-500/20">
                    Procesado para Búsqueda Vectorial
                </p>
            </div>
        );
    }

    return (
        <div className="space-y-4">
            <div className="bg-emerald-500/10 border border-emerald-500/20 p-4 rounded-xl flex items-center gap-3">
                <div className="w-2 h-2 bg-emerald-500 rounded-full animate-pulse"></div>
                <p className="text-sm text-emerald-400">Base de datos PostgreSQL generada: <span className="font-mono">{data.table}</span></p>
            </div>

            <div className="overflow-x-auto rounded-lg border border-white/10">
                <p className="p-4 text-xs text-white/40 italic">La base de datos está lista para consultas SQL y análisis de IA.</p>
                {/* Aquí se podría añadir un grid de datos real si el API devuelve el head del DF */}
            </div>
        </div>
    );
}
