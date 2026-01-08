from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import Dict
import json, csv, os
from datetime import datetime

APP_ORIGINS = ["http://localhost:3000"]

# Question indices: first item = anchor, next two = backups
MAP_QIDX = {
    "language/speaking":     {"anchor":[0],  "backups":[1,2]},
    "language/reading":      {"anchor":[3],  "backups":[4,5]},
    "language/writing":      {"anchor":[6],  "backups":[7,8]},
    "language/career":       {"anchor":[9],  "backups":[10,11]},
    "math/applied":          {"anchor":[12], "backups":[13,14]},
    "math/statistics":       {"anchor":[15], "backups":[16,17]},
    "science/basic":         {"anchor":[18], "backups":[19,20]},
    "science/health":        {"anchor":[21], "backups":[22,23]},
    "science/tech":          {"anchor":[24], "backups":[25,26]},
    "science/environment":   {"anchor":[27], "backups":[28,29]},
    "social/culture":        {"anchor":[30], "backups":[31,32]},
    "social/economics":      {"anchor":[33], "backups":[34,35]},
    "humanities/psychology": {"anchor":[36], "backups":[37,38]},
    "humanities/qol":        {"anchor":[39], "backups":[40,41]},
    "humanities/ethics":     {"anchor":[42], "backups":[43,44]},
    "technology/it":         {"anchor":[45], "backups":[46,47]},
    "technology/engineering":{"anchor":[48], "backups":[49,50]},
    "technology/energy_materials": {"anchor":[51], "backups":[52,53]},
    "sports_rec/sports":     {"anchor":[54], "backups":[55,56]},
    "sports_rec/games_social":{"anchor":[57], "backups":[58,59]},
    "sports_rec/exercise":   {"anchor":[60], "backups":[61,62]}
}

SUBTREE = {
    "language/*": ["language/speaking","language/reading","language/writing","language/career"],
    "math/*": ["math/applied","math/statistics"],
    "science/*": ["science/basic","science/health","science/tech","science/environment"],
    "social/*": ["social/culture","social/economics"],
    "humanities/*": ["humanities/psychology","humanities/qol","humanities/ethics"],
    "technology/*": ["technology/it","technology/engineering","technology/energy_materials"],
    "sports_rec/*": ["sports_rec/sports","sports_rec/games_social","sports_rec/exercise"]
}

# Thai category → tag (domain or subdomain) per your table
TAGS_THAI = {
    "ภาษา": "language/*",
    "การพูด": "language/speaking",
    "การอ่าน": "language/reading",
    "การเขียน": "language/writing",
    "ภาษาเพื่ออาชีพ": "language/career",

    "คณิตศาสตร์": "math/*",
    "ประยุกต์/เทคโนโลยี": "math/applied",
    "สถิติ/วิจัย": "math/statistics",

    "วิทยาศาสตร์": "science/*",
    "วิทย์พื้นฐาน": "science/basic",
    "วิทย์สุขภาพ": "science/health",
    "วิทย์เทคโนโลยี": "science/tech",
    "สิ่งแวดล้อม/พลังงาน": "science/environment",

    "สังคมศาสตร์": "social/*",
    "สังคมวัฒนธรรม": "social/culture",
    "เศรษฐศาสตร์/ธุรกิจ": "social/economics",

    "มนุษย์ศาสตร์": "humanities/*",
    "จิตวิทยา/พฤติกรรม": "humanities/psychology",
    "คุณภาพชีวิต": "humanities/qol",
    "คุณธรรม/จริยธรรม": "humanities/ethics",

    "เทคโนโลยี": "technology/*",
    "ไอที": "technology/it",
    "วิศวกรรมพื้นฐาน": "technology/engineering",
    "พลังงาน/วัสดุ": "technology/energy_materials",

    "กีฬาและนันทนาการ": "sports_rec/*",
    "กีฬา": "sports_rec/sports",
    "เกม/นันทนาการสังคม": "sports_rec/games_social",
    "การออกกำลังกาย": "sports_rec/exercise",
}

DATA_DIR = os.path.join(os.path.dirname(__file__), "data")
DB_JSON       = os.path.join(DATA_DIR, "database.json")
CATEGORY_MAP  = os.path.join(DATA_DIR, "category_map.json")
STATS_F       = os.path.join(DATA_DIR, "stats.json")
SURVEY_JSONL  = os.path.join(DATA_DIR, "survey.jsonl")
SURVEY_CSV    = os.path.join(DATA_DIR, "survey.csv")
os.makedirs(DATA_DIR, exist_ok=True)

def load_json(path, default):
    return json.load(open(path, "r", encoding="utf-8")) if os.path.exists(path) else default

def save_json(path, obj):
    with open(path, "w", encoding="utf-8") as f:
        json.dump(obj, f, ensure_ascii=False, indent=2)

def likert_from_ui(v:int)->int:       # -3..3 → 1..7
    return int(v) + 4

def norm_from_ui(v:int)->float:       # -3..3 → 0..1
    return (int(v) + 3) / 6.0

def update_welford(stats, key, x):
    s = stats.get(key, {"n":0,"mean":0.0,"M2":0.0})
    n = s["n"] + 1
    delta = x - s["mean"]
    mean = s["mean"] + delta/n
    delta2 = x - mean
    M2 = s["M2"] + delta*delta2
    stats[key] = {"n": n, "mean": mean, "M2": M2}
    return stats

def zscore(stats, key, x):
    s = stats.get(key, {"n":0,"mean":0.0,"M2":0.0})
    n, mean, M2 = s["n"], s["mean"], s["M2"]
    if n < 2: return x
    var = M2/(n-1)
    sd = var**0.5 if var>0 else 1.0
    return (x - mean)/sd

def map_course_tag(thai_category:str, overrides:dict, code:str):
    if code in overrides: return overrides[code]
    if thai_category in TAGS_THAI: return TAGS_THAI[thai_category]
    # fallback: try domain words inside the string
    for k, v in TAGS_THAI.items():
        if k in thai_category:
            return v
    return None

def sub_value(sub:str, answers:Dict[str,int]):
    a_idx = MAP_QIDX[sub]["anchor"][0]
    a_raw = answers.get(str(a_idx), answers.get(a_idx))
    if a_raw is None:
        return None, []
    la = likert_from_ui(a_raw)
    if la in (1, 7):     # skip when anchor is extreme
        return None, [a_idx]
    used = [a_idx]
    vals = [norm_from_ui(a_raw)]
    for b in MAP_QIDX[sub]["backups"]:
        if str(b) in answers or b in answers:
            v = answers.get(str(b), answers.get(b))
            used.append(b)
            vals.append(norm_from_ui(v))
    return (sum(vals)/len(vals) if vals else None), used

class ScoreReq(BaseModel):
    answers: Dict[str, int]
    metadata: Dict[str, str] | None = None

app = FastAPI()
app.add_middleware(
    CORSMiddleware,
    allow_origins=APP_ORIGINS,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/health")
def health(): return {"ok": True}

@app.post("/score")
def score(req: ScoreReq):
    answers = req.answers or {}
    stats = load_json(STATS_F, {})
    sub_means, used_map = {}, {}

    # per subdomain mean, z when n>=30
    for sub in MAP_QIDX:
        val, used = sub_value(sub, answers)
        if used: used_map[sub] = used
        if val is None: continue
        if stats.get(sub, {}).get("n", 0) >= 30:
            sub_means[sub] = zscore(stats, sub, val)
        else:
            sub_means[sub] = val
        stats = update_welford(stats, sub, val)
    save_json(STATS_F, stats)

    # rollups
    tag_vec = dict(sub_means)
    for dom, subs in SUBTREE.items():
        vals = [sub_means[s] for s in subs if s in sub_means]
        if vals: tag_vec[dom] = sum(vals)/len(vals)

    # score courses
    db = load_json(DB_JSON, [])
    overrides = load_json(CATEGORY_MAP, {})
    scored = []
    for c in db:
        code = str(c.get("code","")).strip()
        name = c.get("name","")
        credit = c.get("credit","")
        desc = c.get("description","")
        thai_cat = str(c.get("category","")).strip()
        tag = map_course_tag(thai_cat, overrides, code)
        if not tag: continue
        s = float(tag_vec.get(tag, 0.0))
        scored.append({"code":code,"name":name,"credit":credit,"desc":desc,"tag":tag,"score":s})

    # diversify ≤3 per domain, sort by score desc then code
    from collections import defaultdict
    out, perdom = [], defaultdict(int)
    for row in sorted(scored, key=lambda r:(-r["score"], r["code"])):
        dom = row["tag"].split("/")[0]
        if perdom[dom] >= 3: continue
        out.append(row); perdom[dom]+=1
        if len(out) == 5: break

    # logs
    now = datetime.utcnow().isoformat()
    with open(SURVEY_JSONL, "a", encoding="utf-8") as f:
        f.write(json.dumps({"ts":now,"answers":answers,"used_questions":used_map}, ensure_ascii=False)+"\n")
    new_csv = not os.path.exists(SURVEY_CSV)
    with open(SURVEY_CSV, "a", newline="", encoding="utf-8") as f:
        w = csv.writer(f); 
        if new_csv: w.writerow(["ts","answers_json"])
        w.writerow([now, json.dumps(answers, ensure_ascii=False)])

    return {"top_k": out, "user_vector": tag_vec, "used_questions": used_map, "version": "2025-10-26"}