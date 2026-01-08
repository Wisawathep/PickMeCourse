"use client";

import Link from "next/link";
import { useSession, signIn, signOut } from "next-auth/react";
import { User } from "../../components/icons/User";

export default function Navbar() {
  const { data: session } = useSession();
  return (
    <nav className="shadow-md fixed top-0 left-0 w-full z-50" style={{backgroundColor: "#ffffffff"}}>
      <div className="px-6 py-4 flex justify-between items-center">
        <div className="text-2xl font-bold text-black">PICK ME COURSE</div>

        <div className="flex space-x-6 items-center">
          <Link href="/">
            <button className="hover:text-[#eb4446] font-medium transition-colors duration-200">
              Home
            </button>
          </Link>

          <Link href="/search">
            <button className="hover:text-[#eb4446] font-medium transition-colors duration-200">
              Search
            </button>
          </Link>

          {session ? (
            <>
              <div className="flex items-center space-x-2">
                <div className="rounded-full">
                  <User 
                    width={23} 
                    height={23} 
                    stroke="#000000ff"
                    strokeWidth={2}
                  />
                </div>
                
                <div className="text-sm text-gray-700 text-left">
                  <div className="font-semibold">{session.user?.name}</div>
                  <div className="text-xs text-gray-500">{session.user?.email}</div>
                </div>
              </div>

              <button
                onClick={() => signOut()}
                className="px-4 py-2 border border-red-600 text-red-600 rounded-lg font-medium hover:bg-red-600 hover:text-white transition"
              >
                Logout
              </button>
            </>
          ) : (
            <button
              onClick={() => signIn("google")}
              className="px-4 py-2 border border-green-600 text-green-600 rounded-lg font-medium hover:bg-green-600 hover:text-white transition"
            >
              Login
            </button>
          )}

          <Link href="/survey">
            <button className="px-4 py-2 bg-[#eb4446] text-white rounded-lg font-medium hover:bg-[#d43739] transition">
              Take a Survey
            </button>
          </Link>
        </div>
      </div>
    </nav>
  );
}