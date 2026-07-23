"use client";

import { useState } from "react";
import { API_URL } from "@/lib/config";

export default function FileUploader({ onUploadSuccess }: { onUploadSuccess: (data: any) => void }) {
    const [isUploading, setIsUploading] = useState(false);
    const [error, setError] = useState("");

    const handleUpload = async (e: React.ChangeEvent<HTMLInputElement>) => {
        const file = e.target.files?.[0];
        if (!file) return;

        setIsUploading(true);
        setError("");

        const formData = new FormData();
        formData.append("file", file);

        try {
            const response = await fetch(`${API_URL}/upload`, {
                method: "POST",
                headers: { "Authorization": `Bearer ${localStorage.getItem("sas_token")}` },
                body: formData,
            });

            const data = await response.json();
            if (data.status === "success") {
                onUploadSuccess({ ...data, filename: file.name });
            } else {
                setError(data.message || "Error al subir archivo");
            }
        } catch (err) {
            setError("No se pudo conectar con el servidor central");
        } finally {
            setIsUploading(false);
        }
    };

    return (
        <div className="relative group animate-lux w-full">
            <input
                type="file"
                id="fileInput"
                className="hidden"
                onChange={handleUpload}
                disabled={isUploading}
            />
            <label
                htmlFor="fileInput"
                className="flex flex-col items-center justify-center p-16 md:p-24 rounded-[3.5rem] bg-white/[0.02] border border-white/5 hover:border-violet-500/50 hover:bg-white/[0.04] transition-all duration-700 cursor-pointer shadow-2xl relative overflow-hidden group"
            >
                {/* Background Glow */}
                <div className="absolute inset-0 bg-gradient-to-br from-violet-600/5 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-700" />

                <div className="w-20 h-20 bg-white/[0.03] rounded-3xl flex items-center justify-center mb-8 border border-white/10 transition-all duration-700 group-hover:scale-110 group-hover:bg-violet-600 group-hover:border-violet-400 group-hover:shadow-2xl group-hover:shadow-violet-500/50 relative z-10">
                    <svg width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round" className={`transition-colors duration-700 ${isUploading ? "text-violet-400 animate-bounce" : "text-violet-400 group-hover:text-white"}`}>
                        <path d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M15 13l-3-3m0 0l-3 3m3-3v12" />
                    </svg>
                </div>

                <div className="text-center relative z-10">
                    <h3 className="text-2xl font-black text-white mb-3 tracking-tighter">
                        {isUploading ? "Sincronizando..." : "Ingesta de Datos"}
                    </h3>
                    <p className="text-slate-500 text-sm font-medium max-w-[240px] leading-relaxed mx-auto">
                        Sube tu archivo para transformarlo en una base de datos PostgreSQL <span className="text-violet-500">Lux</span>.
                    </p>
                </div>

                <div className="mt-10 flex gap-4 text-[10px] font-black text-slate-600 uppercase tracking-[0.2em]">
                    <span className="px-3 py-1.5 rounded-lg border border-white/5 bg-white/[0.01]">XLSX</span>
                    <span className="px-3 py-1.5 rounded-lg border border-white/5 bg-white/[0.01]">CSV</span>
                    <span className="px-3 py-1.5 rounded-lg border border-white/5 bg-white/[0.01]">PDF</span>
                </div>
            </label>

            {error && (
                <div className="mt-6 p-4 rounded-2xl bg-red-500/10 border border-red-500/20 text-red-500 text-[10px] font-black tracking-widest text-center animate-lux">
                    {error.toUpperCase()}
                </div>
            )}
        </div>
    );
}
