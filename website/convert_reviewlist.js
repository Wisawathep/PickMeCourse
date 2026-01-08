const fs = require("fs");
const csv = require("csvtojson");

const csvFilePath = "./src/app/data/reviewlist.csv"; 
const jsonFilePath = "./src/app/data/reviewlist.json";

csv()
  .fromFile(csvFilePath)
  .then((jsonObj) => {
    const filtered = jsonObj.map(item => ({
      reviewcode: item["รหัสวิชา"],
      section: item["section"],                         
      star: item["คะแนน"],
      review: item["เนื้อหาที่รีวิว"],
      date: item["วันที่รีวิว"],                 
    }));

    fs.writeFileSync(jsonFilePath, JSON.stringify(filtered, null, 2));
    console.log("Convert convert_reviewlist.csv to reviewlist.json Completely!");
  });
