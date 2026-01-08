//website/src/app/layout.js
import "./globals.css";
import Navbar from "./components/navbar";
import Head from "next/head";
import { Providers } from "./providers";

export const metadata = {
  title: "Pick Me Course",
  description: "Find your ideal free elective courses by Pick Me Course"
};

export default function RootLayout({ children }) {
  return (
    <html lang="th">
      <head>
        <link rel="icon" type="image/png" href="/surveylogo.png" />
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossOrigin="true" />
        <link
          href="https://fonts.googleapis.com/css2?family=Kanit:wght@100;200;300;400;500;600;700;800;900&display=swap"
          rel="stylesheet" />
      </head>

      <body className="font-sans antialiased">
        <Providers>
        <Navbar/>
        <main>{children}</main>
        </Providers>
      </body>
    </html>
  );
}
