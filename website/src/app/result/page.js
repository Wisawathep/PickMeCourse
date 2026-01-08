//website/src/app/result/page.js
"use client";
import React, { useEffect, useState } from "react";

export default function ResultPage() {
  const [data, setData] = useState(null);
  const [err, setErr] = useState(null);

  useEffect(() => {
    // 1) Use cached result if available
    const cached = localStorage.getItem("pmc_result");
    if (cached) {
      try { setData(JSON.parse(cached)); return; } catch {}
    }

    // 2) Otherwise load answers and call backend
    try {
      const raw = localStorage.getItem("pmc_answers") || "{}";
      const answers = JSON.parse(raw);
      (async () => {
        try {
          const res = await fetch("http://localhost:8000/score", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ answers })
          });
          const result = await res.json();
          setData(result);
          localStorage.setItem("pmc_result", JSON.stringify(result));
        } catch (e) {
          setErr(e?.message || "fetch failed");
        }
      })();
    } catch (e) {
      setErr("invalid answers in localStorage");
    }
  }, []);

  if (err) {
    return (
      <div className="flex justify-center items-center h-screen text-lg text-red-600">
        เกิดข้อผิดพลาด: {String(err)}
      </div>
    );
  }

  if (!data) {
    return (
      <div className="flex justify-center items-center h-screen text-lg text-gray-600">
        กำลังประมวลผล...
      </div>
    );
  }

  const topCourses = Array.isArray(data?.top_k) ? data.top_k : [];

  if (topCourses.length === 0) {
    return (
      <div className="min-h-screen bg-gradient-to-b from-white to-gray-100 fadein-bottom">
        <div className="max-w-3xl mx-auto py-16 px-6 text-center">
          <h1 className="text-3xl font-bold text-gray-800 mb-4">ยังไม่มีคำแนะนำ</h1>
          <p className="text-gray-600">
            โปรดทำแบบสอบถามให้ครบและกดส่งจากหน้าแบบสอบถามก่อน หรือให้แน่ใจว่า
            backend FastAPI เปิดอยู่ที่ <code>http://localhost:8000/score</code>.
          </p>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gradient-to-b from-white to-gray-100 fadein-bottom">
      {/* 🔹 Section ด้านบนแบบ Hero */}
      <div className="bg-[#ff9a9dae] text-gray-800 relative py-16 px-6 text-left mt-15">
        <div className="max-w-4xl mx-auto">
          <h1 className="text-5xl md:text-4xl font-extrabold mb-2">
            ผลแนะนำรายวิชาเลือก 5 อันดับ
          </h1>
        </div>
      </div>

      {/* 🔹 รายวิชา Top 5 ด้านล่าง */}
      <section className="max-w-5xl mx-auto py-12 px-6">
        <div className="space-y-6">
          {topCourses.map((course, index) => {
            const rankColor = index === 0 ? "#F79327" : index === 1 ? "#adb5bd" : index === 2 ? "#bc732aff" : "#474f5cff";
            const scorePct = typeof course.score === "number" ? (course.score * 100).toFixed(1) : "0.0";
            return (
              <div
                key={course.code || index}
                className="bg-white rounded-2xl shadow-md hover:shadow-lg transition-all p-6 border-[#F79327]"
              >
                <div className="flex justify-between items-start">
                  <h4 className="text-xl font-semibold">
                    <span style={{ color: rankColor }}>#{index + 1}</span>{" "}
                    <span className="text-gray-800">{course.name || "-"}</span>
                  </h4>
                  <span className="text-gray-600 text-sm">คะแนน : {scorePct}%</span>
                </div>

                <p className="mt-1 text-gray-700">รหัสวิชา : {course.code || "-"}</p>
                <p className="mt-1 text-gray-700">หน่วยกิต : {course.credit || "-"}</p>
                <p className="mt-1 text-gray-700">{course.desc || "-"}</p>
              </div>
            );
          })}
        </div>
      </section>
    </div>
  );
}