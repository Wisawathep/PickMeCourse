// app/page.js
"use client";

import { useRef } from "react";
import Link from "next/link";
import Navbar from "./components/navbar";
import CurvedLoop from "../components/CurvedLoop";
import ClickSpark from '../components/ClickSpark';

const courses = [
  { id: 1, name: "ทักษะการนำเสนอ (Oral Presentation)", color: "bg-white" },
  { id: 2, name: "คาราโอเกะ (Karaoke)", color: "bg-white" },
  { id: 3, name: "พัฒนาบุคลิกภาพ (Personality Development)", color: "bg-white" },
  { id: 4, name: "สมุนไพรเพื่อสุขภาพ (Herbs for Health)", color: "bg-white" },
  { id: 5, name: "สายพันธุ์นวัตกร (Innovator's DNA)", color: "bg-white" },
];

export default function HomePage() {
  const containerRef = useRef(null);
  const scroll = (direction) => {
    if (containerRef.current) {
      const width = containerRef.current.offsetWidth;
      containerRef.current.scrollBy({
        left: direction === "left" ? -width / 2 : width / 2,
        behavior: "smooth",
      });
    }}
  return (
    <div className="bg-gradient-to-b from-white to-gray-500 min-h-screen flex flex-col">
      {/* Navigator Bar */}
      <Navbar />

      {/* Hero Section */}
      <div className="min-h-screen w-full relative">
      <div
        className="absolute inset-0 z-0"
        style={{
        background: "linear-gradient(180deg, #ff9a9e 0%, #fad0c4 50%, #fad0c4 100%)",
        }}/>

      {/* Content with relative positioning to appear above background */}
      <div className="relative z-10 -mt-40">
        {/* Hero Section */}
        <ClickSpark
        sparkColor='#fff'
        sparkSize={10}
        sparkRadius={15}
        sparkCount={8}
        duration={400}>

        <CurvedLoop className="fadein-bottom"
        marqueeText="Pick ✦ Me ✦ Course ✦"
        curveAmount={200}
        speed={0.80}
        />
        <section className="max-w-6xl mx-auto text-center py-32 px-6 flex-grow">
          <h1 className="text-4xl md:text-6xl font-extrabold text-gray-800 fadein-bottom -mt-80">
            Discover Yourself with{" "}
            <span className="text-[#eb4446]">PICK ME COURSE</span>
          </h1>
          <p className="mt-6 text-lg text-gray-600 max-w-2xl mx-auto fadein-bottom">
            แบบสำรวจความถนัดและความสนใจ เพื่อเลือกวิชาเสรีที่ตรงใจคุณมากที่สุด
          </p>
          <div className="mt-8 flex justify-center space-x-4">
            <Link href="/survey">
              <button className="px-6 py-3 bg-[#eb4446] text-white rounded-lg font-bold hover:bg-[#d43739] transition fadein-bottom">
                เริ่มทำแบบสอบถาม
              </button>
            </Link>
          </div>
        </section>

        {/* Illustration Section */}
        <section className="max-w-5xl mx-auto px-6 py-16 grid md:grid-cols-2 gap-10 items-center flex-grow -mt-30">
          <img
            src="/characters.png"
            alt="Illustration"
            className="w-full h-auto fadein-bottom"/>
          <div>
            <h2 className="text-2xl font-bold text-gray-800 mb-4 fadein-bottom">
              ทำไมต้องทำแบบสอบถามนี้?
            </h2>
            <p className="text-gray-700 mb-4 fadein-bottom">
              เพราะการเลือกวิชาเสรีไม่ได้มีแค่สิ่งที่ "ง่าย" แต่ยังมีสิ่งที่ "เหมาะสมกับคุณ" มากที่สุด
            </p>
            <ul className="list-disc list-inside text-gray-700 fadein-bottom">
              <li>เข้าใจตัวเองมากขึ้น</li>
              <li>เลือกวิชาได้ตรงใจ</li>
              <li>พัฒนาศักยภาพในสิ่งที่ถนัด</li>
            </ul>
          </div>
        </section>

        <section className="max-w-6xl mx-auto px-6 py-16 -mt-10">
          <h2 className="text-3xl font-bold text-center text-gray-800 mb-10 fadein-bottom">
            รายวิชาเลือกยอดนิยม !
          </h2>
          <div className="relative">
        {/* Scroll buttons */}
        <button
          onClick={() => scroll("left")}
          className="absolute left-2 top-1/2 -translate-y-1/2 z-20 bg-gray-200 p-2 rounded-full shadow hover:bg-gray-300"
        >
          ◀
        </button>
        <button
          onClick={() => scroll("right")}
          className="absolute right-2 top-1/2 -translate-y-1/2 z-20 bg-gray-200 p-2 rounded-full shadow hover:bg-gray-300"
        >
          ▶
        </button>

        <div
          ref={containerRef}
          className="flex overflow-x-auto space-x-4 scrollbar-hide scroll-smooth"
        >
          {[...courses, ...courses].map((course, idx) => (
            <div
              key={idx}
              className={`flex-shrink-0 w-120 h-32 rounded-lg flex items-center justify-center text-gray-800 font-bold text-xl ${course.color}`}
            >
              {course.name}
            </div>
          ))}
        </div>
      </div>
        </section>

        <section className="max-w-6xl mx-auto px-6 py-16 -mt-10">
          <h2 className="text-3xl font-bold text-center text-gray-800 mb-10">
            สมาชิกทีม
          </h2>

          <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-4 gap-6">
            <div className="bg-white shadow-lg rounded-lg p-6 flex flex-col items-center">
              <img
                src="/wisawathep.jpg"
                alt="Team Member 1"
                className="w-32 h-32 rounded-full mb-4 object-cover"/>
              <h3 className="text-xl font-semibold text-gray-800">Wisawathep</h3>
              <p className="text-gray-500 text-sm mt-1">Frontend Developer</p>
            </div>

            <div className="bg-white shadow-lg rounded-lg p-6 flex flex-col items-center">
              <img
                src="/pitchayapa.jpg"
                alt="Team Member 2"
                className="w-32 h-32 rounded-full mb-4 object-cover"
              />
              <h3 className="text-xl font-semibold text-gray-800">Pitchayapa</h3>
              <p className="text-gray-500 text-sm mt-1">QA Tester</p>
            </div>

            <div className="bg-white shadow-lg rounded-lg p-6 flex flex-col items-center">
              <img
                src="/dhinna.jpg"
                alt="Team Member 3"
                className="w-32 h-32 rounded-full mb-4 object-cover"
              />
              <h3 className="text-xl font-semibold text-gray-800">Dhinna</h3>
              <p className="text-gray-500 text-sm mt-1">Backend Developer</p>
            </div>

            <div className="bg-white shadow-lg rounded-lg p-6 flex flex-col items-center">
              <img
                src="/chaiyaphon.jpg"
                alt="Team Member 4"
                className="w-32 h-32 rounded-full mb-4 object-cover"
              />
              <h3 className="text-xl font-semibold text-gray-800">Chaiyaphon</h3>
              <p className="text-gray-500 text-sm mt-1">Database Designer</p>
            </div>
          </div>
        </section>
        </ClickSpark>
      </div>
    </div>
  </div>
  );
}