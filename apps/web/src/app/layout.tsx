import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "CIVILINK NIGERIA",
  description: "One Platform. Every Nigerian. Endless Opportunities.",
  manifest: "/manifest.webmanifest",
  themeColor: "#123b35"
};

export default function RootLayout({ children }: Readonly<{ children: React.ReactNode }>) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  );
}
