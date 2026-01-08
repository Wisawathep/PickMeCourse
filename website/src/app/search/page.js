//website/src/app/search/page.js
"use client";

import { useState } from "react";
import Link from "next/link";
import Navbar from "../components/navbar";
import coursesData from "../data/database.json";

function slugify(name) {
  return name
    .replace(/-/g, "_") 
    .replace(/\s+/g, "-");
}

export default function SearchPage() {
  const [searchTerm, setSearchTerm] = useState("");
  const [filterCategory, setFilterCategory] = useState("All");
  const categories = ["All", ...new Set(coursesData.map((c) => c.category))];
  const filteredCourses = coursesData.filter((c) => {
    const matchesName = c.name.toLowerCase().includes(searchTerm.toLowerCase());
    const matchesCode = c.code.toLowerCase().includes(searchTerm.toLowerCase());
    const matchesCategory =
      filterCategory === "All" || c.category === filterCategory;
    return (matchesName || matchesCode) && matchesCategory;
  });

  return (
    <div className="bg-gradient-to-b from-white to-gray-500 min-h-screen flex flex-col">
      {/* Navigation Bar */}
      <Navbar />

      <div className="min-h-screen w-full relative">
      <div
        className="absolute inset-0 z-0"
        style={{
        background: "linear-gradient(180deg, #ff9a9dae 0%, #fad0c4 50%, #fad0c4 100%)",
        }}/>

      {/* Header Section */}
      <section className="max-w-6xl mx-auto text-center py-12 px-6 -mb-15 fadein-bottom">
        <header className="max-w-6xl mx-auto py-16 px-6 text-center">
          <h1 className="text-4xl font-extrabold text-gray-800">
            ค้นหารายวิชาเลือกเสรี
          </h1>
          <p className="mt-8 text-gray-600">
            พิมพ์ชื่อวิชาหรือเลือกหมวดเพื่อกรองรายวิชา
          </p>
        </header>
      </section>

      {/* Search Section */}
      <section className="max-w-6xl mx-auto text-center px-6 mb-10">
        <div className="flex flex-col md:flex-row md:items-center md:justify-between gap-8 fadein-bottom">
          <input
            type="text"
            placeholder="ค้นหารายวิชา..."
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
            className="flex-1 px-4 py-3 bg-white border border-white rounded-lg focus:outline-none focus:ring-2 focus:ring-[#eb4446]"
          />
          <select
            value={filterCategory}
            onChange={(e) => setFilterCategory(e.target.value)}
            className="w-full md:w-1/2 px-4 py-3 bg-white border border-white rounded-lg focus:outline-none focus:ring-2 focus:ring-[#eb4446]"
          >
            {categories.map((cat) => (
              <option key={cat} value={cat}>
                {cat}
              </option>
            ))}
          </select>
        </div>
      </section>

      {/* Courses Grid */}
      <div className="max-w-6xl mx-auto px-6 space-y-4 mb-16 fadein-bottom">
        {filteredCourses.length === 0 ? (
          <p className="text-center text-gray-500">ไม่พบวิชาที่ค้นหา</p>
        ) : (
          filteredCourses.map((course, index) => (
            <Link
              key={index}
              href={`/review/${encodeURIComponent(slugify(course.name))}`}
              className="flex flex-col md:flex-row justify-between items-start md:items-center bg-white p-6 rounded-xl shadow hover:shadow-lg transition gap-4"
            >
              <div className="flex-1">
                <p className="text-sm text-gray-400 mb-1">รหัสวิชา : {course.code}</p>
                <h3 className="font-bold text-lg text-gray-800">{course.name}</h3>
                <p className="text-gray-500 mt-1">ประเภท : {course.category}</p>
              </div>
            </Link>
          ))
        )}
      </div>
      </div>
    </div>
  );
}
