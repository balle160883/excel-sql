import type { Metadata } from "next";
import { Outfit } from "next/font/google";
import "./globals.css";
import { Providers } from "./providers";

const outfit = Outfit({
  subsets: ["latin"],
  weight: ["300", "400", "500", "600", "700", "800", "900"],
  display: 'swap',
});

export const metadata: Metadata = {
  title: "NOVA DATA | Gestión de Datos Premium",
  description: "Ingesta inteligente de Excel a PostgreSQL con interfaz Lux Noir",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="es">
      <head>
        {/* Anti-cache for development testing */}
        <meta httpEquiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
      </head>
      <body className={`${outfit.className} antialiased bg-[#030303] text-white`}>
        <Providers>
          {children}
        </Providers>
      </body>
    </html>
  );
}
