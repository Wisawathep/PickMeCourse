//website/src/app/api/route.js
import fs from "fs";
import path from "path";
export const runtime = "nodejs";
export async function POST(req) {
  try {
    const data = await req.json();
    console.log("Survey data:", data);
    const filePath = path.join(process.cwd(), "survey.json");

    let surveys = [];
    if (fs.existsSync(filePath)) {
      const fileData = fs.readFileSync(filePath, "utf8");
      surveys = JSON.parse(fileData);
    }

    surveys.push(data);
    fs.writeFileSync(filePath, JSON.stringify(surveys, null, 2), "utf8");

    return new Response (
      JSON.stringify({ success: true, received: data }),
      { status: 200, headers: { "Content-Type": "application/json" } }
    );
  } catch (err) {
    console.error(err);
    
    return new Response (
      JSON.stringify({ success: false, error: err.message }),
      { status: 500, headers: { "Content-Type": "application/json" } }
    );
  }
}
