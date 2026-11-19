import type { Metadata } from "next";
import "./globals.css";
export const metadata: Metadata = {
  title: "Central de Pedidos",
  description: "Painel privado para organizar pedidos do grupo de promoções."
};
export default function RootLayout({children}:{children:React.ReactNode}) {
  return <html lang="pt-BR"><body>{children}</body></html>;
}
