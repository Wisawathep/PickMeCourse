//website/src/app/survey/page.js
"use client";
import { useState } from "react";
import Navbar from "../components/navbar";

{/* Questions */}
const questions = [
  "คุณรู้สึกสนุกเมื่อได้อธิบายเรื่องต่างๆ เป็นภาษาอังกฤษ",
  "เวลาฟังเจ้าของภาษาพูด คุณมักเผลอลอกเลียนแบบเสียงหรือพูดตาม",
  "คุณรู้สึกมั่นใจเมื่อต้องพูดภาษาอังกฤษเพื่ออธิบายสิ่งที่ซับซ้อน",
  "เวลาอ่านเรื่องยาว ๆ คุณชอบสรุปใจความเองมากกว่าอ่านตามทุกคำ",
  "เมื่อเจอคำศัพท์ที่ไม่รู้ คุณมักจะเดาความหมายของคำก่อนหาคำแปล",
  "คุณมักรู้สึกสนุกเวลาอ่านเรื่อราวจากประเทศหรือต่างวัฒนธรรม",
  "การเขียนภาษาอังกฤษทำให้คุณเข้าใจ และจำเนื้อหาได้ดีขึ้น",
  "คุณรู้สึกสนุกกับการปรับแก้ประโยคภาษาอังกฤษให้กระชับหรือฟังดูเป็นธรรมชาติมากขึ้น",
  "ในงานกลุ่ม คุณมักถนัดเขียนบันทึกหรือสรุปมากกว่าพูด",
  "คุณรู้สึกมีแรงบันดาลใจเมื่อคิดถึงการทำงานในสภาพแวดล้อมที่ต้องใช้ภาษาอังกฤษ",
  "คุณรู้สึกการใช้ภาษาอังกฤษช่วยให้คุณกล้าแสดงออก",
  "คุณมักสังเกตคำศัพท์หรือรูปแบบภาษาที่ใช้ในเฉพาะในสถานการณ์ต่างๆ",
  "คุณรู้สึกสนุกเมื่อได้ใช้คณิตศาสตร์อธิบายปรากฎการณ์ในชีวิตจริง",
  "การได้ใช้เครื่องมือหรือโปรแกรมช่วยคำนวณ ทำให้คุณรู้สึกอยากลองสำรวจมากขึ้น",
  "คุณรู้สึกท้าทายและเพลิดเพลินเมื่อได้แก้ปัญหาด้วยแนวคิดเชิงตัวเลข",
  "เมื่อได้ข้อมูลจำนวนมาก คุณชอบจัดระเบียบออกมาในรูปแบบกราฟหรือแผนภาพ",
  "เวลาเห็นข่าวหรือข้อมูล คุณมักมองหาตัวเลขประกอบการตัดสินใจก่อนจะเชื่อ",
  "คุณรู้สึกว่าตารางหรือกราฟช่วยให้เข้าใจเรื่องราวได้เร็วขึ้น",
  "เวลาเห็นปรากฏการณ์ธรรมชาติ คุณมักสงสัยว่ามันเกิดขึ้นได้ยังไง",
  "คุณรู้สึกตื่นเต้นเวลาได้เห็นการทดลองที่อธิบายหลักการทางวิทยาศาสตร์",
  "ถ้าได้เลือก คุณอยากเข้าใจเหตุผลเบื้องหลังมากกว่าการท่องจำ",
  "คุณมักจะสังเกตพฤติกรรมหรืออาหารที่ส่งผลต่อร่างกายตัวเอง",
  "คุณมักหาข้อมูลเรื่องสมุนไพรหรือยาเวลาป่วยเล็กน้อย",
  "คุณสนใจร่างกายมนุษย์ทำงานอย่างไรในระดับชีววิทยาหรือเคมี",
  "เวลาเห็นสิ่งประดิษฐ์ใหม่ๆ คุณมักอยากรู้ว่ามันทำงานยังไง",
  "คุณชอบลองของใหม่หรือลองใช้อุปกรณ์เทคโนโลยีด้วยตัวเอง",
  "คุณมักคิดหาวิธีใช้เทคโนโลยีเพื่อแก้ปัญหาหรือพัฒนาไอเดียใหม่ๆ",
  "คุณชอบติดตามข่าวสารเกี่ยวกับธรรมชาติ สิ่งแวดล้อม",
  "คุณมักจะสนใจพลังงานสะอาดหรือแนวคิดรีไซเคิล",
  "เวลามีโครงการอนุรักษ์ ฉันมักรู้สึกอยากจะเข้าร่วม",
  "เวลาพบคนต่างพื้นเพ คุณอยากรู้เรื่องราวชีวิตของเขา",
  "คุณมักสนใจดูสารคดี หนัง หรือคอนเทนต์ที่เกี่ยวกับชีวิตของผู้คนในสังคมต่างๆ",
  "คุณชอบสังเกตพฤติกรรมของผู้คนในสถานที่ต่าง ๆ เช่น ตลาด มหาวิทยาลัย",
  "เวลาเห็นราคาสินค้าขึ้นลง คุณมักคิดถึงเหตุผลทางเศรษฐกิจ",
  "คุณอยากศึกษาเรียนรู้เรื่องเศรษฐศาสตร์การลงทุน และการบริหารธุรกิจ",
  "คุณรู้สึกมีแรงบันดาลใจเวลาได้เรียนรู้เรื่องผู้ประกอบการที่เริ่มจากศูนย์แล้วประสบความสำเร็จ",
  "เวลาเห็นคนทำอะไรบางอย่าง คุณมักจะสงสัยไหมว่าเขากำลังคิดอะไรอยู่ในขณะนั้น",
  "คุณชอบวิเคราะห์ความรู้สึกหรือแรงจูงใจของคน",
  "คุณสนใจเรียนรู้ว่าคนแต่ละคนมีวิธีจัดการความคิดและอารมณ์อย่างไร",
  "เวลาทำงานหรือเรียนหนัก คุณพยายามหาสมดุลกับชีวิตส่วนตัว",
  "คุณชอบหาวิธีพัฒนาตัวเองให้มีชีวิตดีขึ้นทั้งกายและใจ",
  "คุณสนุกกับการตั้งเป้าหมายชีวิตและพยายามทำให้สำเร็จ",
  "เวลาเห็นเรื่องขัดแย้ง คุณมักคิดถึงความถูกต้องก่อนผลลัพธ์",
  "คุณมักชอบฟังมุมมองหลากหลายก่อนตัดสินใจ",
  "คุณสนใจเรียนรู้ว่าค่านิยมและจริยธรรมมีอิทธิพลต่อการตัดสินใจของสังคมอย่างไร",
  "คุณชอบอยากรู้เบื้องหลังว่าระบบหรือแอปทำงานยังไง",
  "ถ้าเจอปัญหากับคอมพิวเตอร์ คุณมักหาวิธีแก้เองก่อนขอความช่วยเหลือ",
  "คุณมักสนุกกับการลองใช้แอปหรือโปรแกรมใหม่ๆ",
  "เวลามีของพัง คุณมักพยายามหาวิธีซ่อมหรือดูโครงสร้างของมันก่อนทิ้ง",
  "คุณรู้สึกเพลิดเพลินเวลาได้ออกแบบหรือประกอบของเอง",
  "คุณชอบทดลองและปรับปรุงจนของที่ทำออกมาสมบูรณ์หรือใช้งานได้จริง",
  "คุณมักสงสัยว่าวัสดุแต่ละชนิดมีจุดเด่นยังไง",
  "คุณสนใจหาวิธีรีไซเคิลหรือนำวัสดุกลับมาใช้ใหม่",
  "คุณสนใจติดตามเทคโนโลยีใหม่ ๆ ที่ช่วยลดการใช้พลังงาน",
  "คุณรู้สึกสนุกในกีฬาที่ต้องใช้พละกำลัง",
  "การเล่นกีฬาเป็นวิธีหนึ่งที่ทำให้คุณจัดการกับความเครียดหรืออารมณ์ได้ดี",
  "คุณสนุกกับกิจกรรมที่เกิดการแข่งขัน และมีกติกาที่ชัดเจน",
  "คุณรู้สึกมีพลังเวลาได้เล่นเกมหรือกิจกรรมกับเพื่อนๆ",
  "คุณสนุกกับการวางกลยุทธ์หรือวางแผนในเกมเพื่อเอาชนะความท้าทาย",
  "คุณชอบออกไปทำกิจกรรมทางสังคม เช่น นันทนาการ มากกว่าอยู่บ้าน",
  "คุณมักตั้งเป้าหมายในการออกกำลังกายเพื่อท้าทายตัวเอง",
  "คุณชอบลองออกกำลังกายแนวใหม่ๆ ที่คุณยังไม่เคยลองมาก่อน เช่นโยคะหรือฟิตเนส",
  "การออกกำลังกายช่วยให้คุณมีสมาธิในการทำงานหรือเรียน"
];

// Subdomain groups of 3 questions [anchor, backup1, backup2]
const subdomains = [
  [0,1,2],[3,4,5],[6,7,8],[9,10,11],
  [12,13,14],[15,16,17],
  [18,19,20],[21,22,23],[24,25,26],[27,28,29],
  [30,31,32],[33,34,35],
  [36,37,38],[39,40,41],[42,43,44],
  [45,46,47],[48,49,50],[51,52,53],
  [54,55,56],[57,58,59],[60,61,62]
];
const anchorIdxs = subdomains.map(g => g[0]);

export default function SurveyPage() {
  // API state
  const [answers, setAnswers] = useState({});
  const [step, setStep] = useState(1); // 1 = anchors, 2 = backups
  const [backups, setBackups] = useState([]); // indices to ask on step 2

  const handleChange = (qIndex, value) => {
    setAnswers({ ...answers, [qIndex]: value });
  };

  const submitToBackend = async () => {
    try {
      localStorage.setItem("pmc_answers", JSON.stringify(answers));
      const res = await fetch("http://localhost:8000/score", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ answers })
      });
      const data = await res.json();
      localStorage.setItem("pmc_result", JSON.stringify(data));
      window.location.href = "/result";
    } catch (err) {
      console.error(err);
      alert("Error submitting survey. Please try again.");
    }
  };

  const nextOrSubmit = async () => {
    if (step === 1) {
      // Determine which backups to ask. Extreme anchors {-3,3} → skip; others → ask 2 backups
      const need = [];
      subdomains.forEach(g => {
        const a = g[0];
        const v = answers[a];
        if (v === undefined) return; // unanswered anchors not allowed when button enabled
        if (v !== -3 && v !== 3) {
          need.push(g[1], g[2]);
        }
      });
      if (need.length === 0) {
        // No backups needed. Submit directly.
        await submitToBackend();
        return;
      }
      setBackups(need);
      setStep(2);
      window.scrollTo({ top: 0, behavior: "smooth" });
      return;
    }
    // step 2 → submit
    await submitToBackend();
  };

  // Progress bar uses only visible questions
  const visible = step === 1 ? anchorIdxs : backups;
  const answeredCount = visible.filter(i => answers[i] !== undefined).length;
  const progressPercent = Math.round(((visible.length ? answeredCount / visible.length : 1) * 100));

  return (
    <div className="bg-gradient-to-b from-[#ff9a9dae] to-[#ff9a9dae] flex-1 mx-auto animated-bg" style={{backgroundColor:"#ffffffff"}}>
      {/* Navigator Bar */}
      <Navbar />
      <div className="flex max-w-6xl mx-auto mt-10 gap-6">
        {/* Progress bar */}
        <div className="fixed bottom-0 left-0 w-full bg-white h-12 z-50 flex items-center px-6">
          <div className="flex-1 h-3 bg-gray-200 rounded-full overflow-hidden relative">
            <div
              className="h-full bg-blue-600 rounded-full transition-all duration-500"
              style={{ width: `${progressPercent}%` }}
            ></div>
          </div>
          <div className="ml-4 text-sm font-semibold text-gray-800">
            {answeredCount}/{visible.length || 0} Done · {step===1?"Anchors":"Backups"}
          </div>
        </div>

        {/* Survey Box */}
        <div className="flex-1 bg-white shadow-lg rounded-2xl p-8 space-y-8 mt-10 mb-10">
          <h1 className="text-3xl font-extrabold text-center text-gray-800">
            PICK ME COURSE SURVEY
          </h1>
          <p className="text-center text-gray-500">
            แบบสำรวจด้านความสนใจของคุณ เพื่อให้เราแนะนำวิชาเลือกเสรีที่เหมาะสม
          </p>

          {/* Guide Box */}
          <div className="bg-[white] border-l-4 border-[#ff9a9dae] p-4 rounded-md text-[#eb4446] space-y-2">
            <h2 className="font-semibold text-lg">
              {step===1?"ชุดคำถามหลัก (Anchors)":"คำถามเสริม (Backups)"}
            </h2>
            <ul className="list-disc list-inside text-sm">
              <li>ตั้งสมาธิ จากนั้นอ่านคำถามแต่ละข้ออย่างละเอียด เลือกคำตอบตามความรู้สึกจริงของคุณ</li>
              <li>ตอบด้วยการเลือกวงกลมตามระดับความเห็นด้วยของคุณ</li>
              <li>ไม่มีคำตอบที่ผิดหรือถูก ทุกคำตอบสะท้อนความถนัด และความสนใจของคุณ</li>
            </ul>
          </div>

          {/* Questions Box */}
          {visible.map((index) => {
            const q = questions[index];
            return (
              <div key={index} className="p-4 bg-gray-50 rounded-xl shadow-sm hover:shadow-md transition duration-300">
                <p className="font-medium mb-3 text-gray-700">{q}</p>
                <div className="flex items-center justify-between">
                  <span className="text-green-600 font-semibold">เห็นด้วย</span>
                  <div className="flex space-x-3">
                    {[3, 2, 1, 0, -1, -2, -3].map((num) => {
                      let colorClass = "";
                      if (num > 0) {
                        colorClass = "peer-checked:border-blue-500 peer-checked:bg-blue-200 group-hover:border-blue-400";
                      } else if (num < 0) {
                        colorClass = "peer-checked:border-purple-500 peer-checked:bg-purple-200 group-hover:border-purple-400";
                      } else {
                        colorClass = "peer-checked:border-gray-500 peer-checked:bg-gray-300 group-hover:border-gray-400";
                      }

                      return (
                        <label key={num} className="relative cursor-pointer group" title={num}>
                          <input
                            type="radio"
                            name={`q${index}`}
                            value={num}
                            checked={answers[index] === num}
                            onChange={() => handleChange(index, num)}
                            className="peer sr-only"/>
                          <span
                            className={`block w-7 h-7 rounded-full border-2 border-gray-300 transition duration-300 ${colorClass}`}
                          ></span>
                        </label>
                      );
                    })}
                  </div>
                  <span className="text-purple-600 font-semibold">ไม่เห็นด้วย</span>
                </div>
              </div>
            );
          })}

          {/* Action Buttons */}
          <div className="flex justify-center space-x-4">
            <button
              onClick={nextOrSubmit}
              disabled={visible.length > 0 ? answeredCount !== visible.length : false}
              className={`px-6 py-3 rounded-xl font-bold shadow-lg transition duration-300 
              ${visible.length > 0 && answeredCount !== visible.length 
                ? "bg-gray-400 cursor-not-allowed text-white" 
                : "bg-blue-600 hover:bg-blue-700 text-white"}`}>
                {step===1?"ถัดไป":"ยืนยัน"}
            </button>

            <button
              onClick={() => { setAnswers({}); setStep(1); setBackups([]); }}
              className="px-6 py-3 bg-red-500 hover:bg-red-600 text-white font-bold rounded-xl shadow-lg transition duration-300">
              รีเซ็ต
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}