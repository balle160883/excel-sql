"use client";

import { useState, useRef, useEffect } from "react";

export default function ChatInterface({ collectionName }: { collectionName: string }) {
    const [messages, setMessages] = useState<{ role: string; content: string }[]>([]);
    const [input, setInput] = useState("");
    const [isTyping, setIsTyping] = useState(false);
    const scrollRef = useRef<HTMLDivElement>(null);

    useEffect(() => {
        if (scrollRef.current) {
            scrollRef.current.scrollTop = scrollRef.current.scrollHeight;
        }
    }, [messages]);

    const handleSend = async () => {
        if (!input.trim() || isTyping) return;

        const userMsg = { role: "user", content: input };
        setMessages((prev) => [...prev, userMsg]);
        setInput("");
        setIsTyping(true);

        try {
            const response = await fetch(`http://localhost:8000/chat?question=${encodeURIComponent(input)}&collection_name=${collectionName}`, {
                method: "POST",
            });
            const data = await response.json();
            setMessages((prev) => [...prev, { role: "bot", content: data.answer }]);
        } catch (err) {
            setMessages((prev) => [...prev, { role: "bot", content: "Lo siento, hubo un error al procesar tu pregunta." }]);
        } finally {
            setIsTyping(false);
        }
    };

    return (
        <div className="flex flex-col h-full bg-white/5 rounded-xl overflow-hidden">
            <div ref={scrollRef} className="flex-1 p-4 overflow-y-auto space-y-4 custom-scrollbar">
                {messages.length === 0 && (
                    <p className="text-white/30 text-center mt-12 italic">
                        Haz una pregunta sobre el archivo cargado...
                    </p>
                )}
                {messages.map((msg, i) => (
                    <div key={i} className={`flex ${msg.role === 'user' ? 'justify-end' : 'justify-start'}`}>
                        <div className={`max-w-[80%] p-3 rounded-2xl ${msg.role === 'user' ? 'bg-indigo-600' : 'bg-white/10'}`}>
                            <p className="text-sm">{msg.content}</p>
                        </div>
                    </div>
                ))}
                {isTyping && (
                    <div className="flex justify-start">
                        <div className="bg-white/10 p-3 rounded-2xl animate-pulse">
                            <span className="text-sm">Pensando...</span>
                        </div>
                    </div>
                )}
            </div>

            <div className="p-4 bg-white/5 border-t border-white/10 flex gap-2">
                <input
                    type="text"
                    value={input}
                    onChange={(e) => setInput(e.target.value)}
                    onKeyPress={(e) => e.key === 'Enter' && handleSend()}
                    placeholder="Escribe tu pregunta..."
                    className="flex-1 bg-white/5 border border-white/10 rounded-lg px-4 py-2 focus:outline-none focus:border-indigo-500"
                />
                <button onClick={handleSend} className="neo-button px-4 py-2">
                    <span>Enviar</span>
                </button>
            </div>
        </div>
    );
}
