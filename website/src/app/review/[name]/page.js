"use client";

import { useState, useEffect } from "react";
import { useParams } from "next/navigation";
import { useSession, signIn } from "next-auth/react";  
import Navbar from "../../components/navbar";
import coursesData from "../../data/database.json";
import reviewsData from "../../data/reviewlist.json";

function deslugify(slug) {
  return slug.replace(/-/g, " ").replace(/_/g, "-");
}

export default function CourseReviewPage() {
  const sections = [
    "SEC1", "SEC2", "SEC3", "SEC4", "SEC5",
    "SEC6", "SEC7", "SEC8", "SEC9", "SEC10",
  ];

  const { data: session } = useSession();  
  const { name } = useParams();
  const decodedName = deslugify(decodeURIComponent(name));

  const [courseInfo, setCourseInfo] = useState({
    code: "",
    description: "",
    credit: "",
    sections: [],
    instructor: "",
  });

  const [selectedSection, setSelectedSection] = useState("");
  const [rating, setRating] = useState(0);
  const [comment, setComment] = useState("");
  const [reviews, setReviews] = useState([]);
  const [isWishlisted, setIsWishlisted] = useState(false);
   const [showLoginModal, setShowLoginModal] = useState(false);

  useEffect(() => {
    const course = coursesData.find(
      (c) => c.name.toLowerCase() === decodedName.toLowerCase()
    );
    if (course) {
      setCourseInfo({
        code: course.code || "",
        description: course.description || "",
        credit: course.credit || "",
        sections: course.sections || [],
        instructor: course.instructor || "",
      });

      const oldReviews = reviewsData.filter(r => r.reviewcode === course.code)
        .map(r => ({
          section: r.section,
          rating: Number(r.star),
          comment: r.review,
          date: r.date,
        }));

      setReviews(oldReviews);
    }
  }, [decodedName]);

  const handleWishlistToggle = () => {
    if (!session) {
      setShowLoginModal(true);
      return;
    }
    setIsWishlisted(!isWishlisted);
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    if (!session) {
      alert("กรุณาเข้าสู่ระบบก่อนรีวิว 💬");
      signIn();
      return;
    }
    if (rating === 0) return;

    const newReview = { 
      rating, 
    comment: comment.trim() || "-", 
    section: selectedSection || "SEC1", 
    date: new Date().toLocaleDateString() };
    setReviews([newReview, ...reviews]);
    setRating(0);
    setComment("");
  };

  return (
    <div className="bg-gradient-to-b from-white to-gray-100 min-h-screen flex flex-col">
      <Navbar />

      {showLoginModal && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/40 backdrop-blur-sm">
          <div className="bg-white rounded-2xl shadow-lg p-8 max-w-sm text-center animate-fadein">
            <h2 className="text-2xl font-semibold text-gray-800 mb-3">
              🔒 กรุณาเข้าสู่ระบบ
            </h2>
            <p className="text-gray-600 mb-6">
              เพื่อเพิ่มรายวิชาโปรดของคุณใน Wishlist 💖
            </p>
            <div className="flex justify-center gap-3">
              <button
                onClick={() => {
                  setShowLoginModal(false);
                }}
                className="px-5 py-2 rounded-lg border border-gray-300 text-gray-600 hover:bg-gray-100"
              >
                ปิด
              </button>
              <button
                onClick={() => signIn()}
                className="px-5 py-2 rounded-lg bg-[#eb4446] text-white font-semibold hover:bg-[#d43739]"
              >
                เข้าสู่ระบบ
              </button>
            </div>
          </div>
        </div>
      )}

      <div className="min-h-screen w-full relative">
        <div
          className="absolute inset-0 z-0"
          style={{
            background: "linear-gradient(180deg, #ff9a9dae 0%, #fad0c4 50%, #fad0c4 100%)",
          }}
        />

        {/* Header */}
        <div className="relative text-center z-10">
          <section className="max-w-4xl mx-auto text-center py-12 px-6 mt-15">
            <h1 className="text-4xl font-extrabold text-gray-800 fadein-bottom">
              {decodedName}
            </h1>
            <p className="mt-4 text-gray-600 fadein-bottom">ให้คะแนนและรีวิววิชานี้</p>
          </section>

          {/* Main Content */}
          <section className="max-w-6xl mx-auto px-0 mb-12 flex flex-col md:flex-row gap-8">
            {/* Left Column */}
            <div className="md:w-1/2 bg-white p-6 rounded-l-xl shadow space-y-4 fadein-bottom">
              <button
                onClick={handleWishlistToggle}
                className="absolute top-4 right-4 text-3xl transition focus:outline-none"
              >
                {isWishlisted ? (
                  <span className="text-pink-500">❤</span>
                ) : (
                  <span className="text-gray-300 hover:text-pink-400">❤</span>
                )}
              </button>

              <p className="text-sm text-left text-gray-400">รหัสวิชา : {courseInfo.code || "-"}</p>
              <h2 className="text-left text-xl font-bold text-gray-800">{decodedName}</h2>
              <p className="text-left text-gray-600">{courseInfo.description || "-"}</p>
              <p className="text-left text-gray-500">หน่วยกิต : {courseInfo.credit || "-"}</p>
              <p className="text-left text-gray-500">อาจารย์ผู้สอน : {courseInfo.instructor || "-"}</p>

              {/* Section Filter */}
              <div className="mt-4">
                <label className="block text-left text-gray-700 font-medium mb-2">เลือก Section</label>
                <select
                  value={selectedSection}
                  onChange={(e) => setSelectedSection(e.target.value)}
                  className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-[#eb4446]"
                >
                  {(courseInfo.sections.length > 0 ? courseInfo.sections : sections).map((sec) => (
                    <option key={sec} value={sec}>{sec}</option>
                  ))}
                </select>
              </div>
            </div>

            {/* Right Column */}
            <div className="md:w-1/2 bg-white p-6 rounded-r-xl shadow space-y-6 fadein-bottom">
              {!session ? (
                <div className="text-center space-y-4 py-8">
                  <p className="text-gray-600 text-lg">
                    🔒 กรุณาเข้าสู่ระบบเพื่อรีวิวรายวิชา
                  </p>
                  <button
                    onClick={() => signIn()}
                    className="px-6 py-3 bg-[#eb4446] text-white font-bold rounded-lg hover:bg-[#eb4446] transition"
                  >
                    เข้าสู่ระบบ
                  </button>
                </div>
              ) : (
                <form onSubmit={handleSubmit} className="space-y-6">
                  {/* Rating */}
                  <div>
                    <label className="block text-gray-700 text-left font-medium mb-2">คะแนนดาว</label>
                    <div className="flex space-x-2">
                      {[1, 2, 3, 4, 5].map((star) => (
                        <button
                          key={star}
                          type="button"
                          onClick={() => setRating(star)}
                          className={`text-2xl ${rating >= star ? "text-yellow-400" : "text-gray-300"}`}
                        >
                          ★
                        </button>
                      ))}
                    </div>
                  </div>

                  {/* Comment */}
                  <div>
                    <label className="block text-gray-700 text-left font-medium mb-2">ความคิดเห็น</label>
                    <textarea
                      value={comment}
                      onChange={(e) => setComment(e.target.value)}
                      rows="4"
                      className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-[#eb4446]"
                      placeholder="พิมพ์ความคิดเห็นของคุณ..."
                    />
                  </div>

                  <button
                    type="submit"
                    className="w-full py-3 bg-[#eb4446] text-white font-bold rounded-lg hover:bg-[#d43739] transition"
                    disabled={rating === 0}
                  >
                    ส่งรีวิว
                  </button>
                </form>
              )}
            </div>
          </section>

          {/* Reviews List */}
          <section className="max-w-6xl mx-auto px-6 mb-16">
            <h2 className="text-2xl font-bold text-gray-800 mb-6">รีวิวล่าสุด</h2>
            {reviews.length === 0 ? (
              <p className="text-gray-500">ยังไม่มีรีวิว</p>
            ) : (
              <div className="space-y-6">
                {reviews.map((review, index) => (
                  <div key={index} className="bg-white p-6 rounded-xl fadein-bottom shadow">
                    <p className="text-left text-yellow-400 text-lg">
                      {"★".repeat(review.rating)}{" "}
                      <span className="text-gray-400">
                        {"★".repeat(5 - review.rating)}
                      </span>
                    </p>
                    <p className="text-left text-gray-500 text-sm">ตอนเรียน : {review.section}</p>
                    <p className="text-left text-gray-500 text-sm">วันที่รีวิว : {review.date}</p>
                    <p className="text-left text-gray-600 mt-1">{review.comment}</p>
                  </div>
                ))}
              </div>
            )}
          </section>
        </div>
      </div>
    </div>
  );
}