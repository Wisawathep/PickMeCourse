const fs = require("fs");
const csv = require("csvtojson");

const csvFilePath = "./src/app/data/database.csv"; 
const jsonFilePath = "./src/app/data/database.json";

csv()
  .fromFile(csvFilePath)
  .then((jsonObj) => {
    const filtered = jsonObj.map(item => ({
      code: item["รหัสวิชา"],                     
      name: item["รายชื่อวิชา"],      
      category: item["ประเภทวิชา"],
      credit: item["หน่วยกิต"],
      description: item["คำอธิบาย"],
      instructor: item["ชื่ออาจารย์ผู้สอน"],                  
    }));

    fs.writeFileSync(jsonFilePath, JSON.stringify(filtered, null, 2));
    console.log("Convert .CSV to .JSON Completely!");
  });
