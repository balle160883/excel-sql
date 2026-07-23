import React, { useState, useEffect } from 'react';

interface DynamicFormProps {
    initialData: any;
    columns: string[];
    onSubmit: (data: any) => void;
    onCancel: () => void;
    primaryKey?: string;
    isNew?: boolean;
    pkHasDefault?: boolean;
}

const DynamicForm: React.FC<DynamicFormProps> = ({ initialData, columns, onSubmit, onCancel, primaryKey, isNew = false, pkHasDefault = false }) => {
    const [formData, setFormData] = useState<any>(initialData || {});

    useEffect(() => {
        setFormData(initialData || {});
    }, [initialData]);

    const handleChange = (key: string, value: any) => {
        setFormData((prev: any) => ({
            ...prev,
            [key]: value
        }));
    };

    const handleSubmit = (e: React.FormEvent) => {
        e.preventDefault();
        onSubmit(formData);
    };

    return (
        <form onSubmit={handleSubmit} className="space-y-8">
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-x-6 gap-y-5">
                {columns.map((col) => {
                    const isPk = col === primaryKey;
                    const isFieldDisabled = isPk && (!isNew || pkHasDefault);

                    return (
                        <div key={col} className="group flex flex-col gap-2">
                            <label className="text-[10px] font-bold text-slate-500 uppercase tracking-widest pl-1 group-focus-within:text-purple-400 transition-colors">
                                {col.replace(/_/g, ' ')}
                            </label>
                            <div className="relative">
                                <input
                                    type="text"
                                    value={formData[col] === null ? '' : String(formData[col] ?? '')}
                                    onChange={(e) => handleChange(col, e.target.value)}
                                    disabled={isFieldDisabled}
                                    placeholder={`Ingresar ${col.replace(/_/g, ' ')}...`}
                                    className={`w-full px-4 py-3 bg-black/20 border rounded-xl text-sm transition-all focus:outline-none 
                                        ${isFieldDisabled
                                            ? 'border-white/5 text-slate-600 bg-white/[0.02] cursor-not-allowed'
                                            : 'border-white/10 text-slate-200 focus:border-purple-500/50 focus:ring-4 focus:ring-purple-500/10 hover:border-white/20'}`}
                                />
                                {isFieldDisabled && (
                                    <div className="absolute right-3 top-3">
                                        <svg className="w-4 h-4 text-slate-700" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" />
                                        </svg>
                                    </div>
                                )}
                            </div>
                        </div>
                    );
                })}
            </div>

            <div className="flex items-center justify-end gap-4 pt-8 border-t border-white/5 mt-6">
                <button
                    type="button"
                    onClick={onCancel}
                    className="px-6 py-3 text-sm font-bold text-slate-400 hover:text-white hover:bg-white/5 rounded-xl transition-all"
                >
                    Descartar
                </button>
                <button
                    type="submit"
                    className="lux-button px-8 py-3 text-sm font-bold text-white shadow-xl shadow-purple-500/10"
                >
                    Aplicar Cambios
                </button>
            </div>
        </form>
    );
};

export default DynamicForm;
