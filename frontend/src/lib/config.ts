
let apiUrl = process.env.NEXT_PUBLIC_API_URL || "http://localhost:8001";

// Si el frontend está corriendo en HTTPS, forzar a que la API también use HTTPS para evitar errores de Mixed Content
if (typeof window !== "undefined" && window.location.protocol === "https:" && apiUrl.startsWith("http://")) {
    apiUrl = apiUrl.replace("http://", "https://");
}

export const API_URL = apiUrl;
