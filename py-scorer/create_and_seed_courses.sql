-- Auto-generated on 2025-10-26T03:52:08.260838 by ChatGPT
BEGIN;

CREATE TABLE IF NOT EXISTS course_types (
  id          INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name        VARCHAR(100) NOT NULL UNIQUE
);


CREATE TABLE IF NOT EXISTS categories (
  id          INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name        VARCHAR(100) NOT NULL UNIQUE
);


CREATE TABLE IF NOT EXISTS faculty_groups (
  id          INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name        VARCHAR(150) NOT NULL UNIQUE
);


CREATE TABLE IF NOT EXISTS courses (
  course_code       VARCHAR(50) PRIMARY KEY,
  title_th          VARCHAR(255) NOT NULL,
  description_th    TEXT,
  type_id           INTEGER REFERENCES course_types(id) ON UPDATE CASCADE ON DELETE SET NULL,
  category_id       INTEGER REFERENCES categories(id) ON UPDATE CASCADE ON DELETE SET NULL,
  faculty_group_id  INTEGER REFERENCES faculty_groups(id) ON UPDATE CASCADE ON DELETE SET NULL,
  credits           NUMERIC(4,1) CHECK (credits >= 0),
  theory_hours      INTEGER DEFAULT 0 CHECK (theory_hours >= 0),
  lab_hours         INTEGER DEFAULT 0 CHECK (lab_hours >= 0),
  self_study_hours  INTEGER DEFAULT 0 CHECK (self_study_hours >= 0)
);


CREATE TABLE IF NOT EXISTS instructors (
  id          INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  title       VARCHAR(50),
  first_name  VARCHAR(100) NOT NULL,
  last_name   VARCHAR(100) NOT NULL,
  email       VARCHAR(200),
  CONSTRAINT uq_instructor_min UNIQUE (first_name, last_name, email)
);


CREATE TABLE IF NOT EXISTS course_instructors (
  course_code   VARCHAR(50) NOT NULL REFERENCES courses(course_code)
                  ON UPDATE CASCADE ON DELETE CASCADE,
  instructor_id INTEGER NOT NULL REFERENCES instructors(id)
                  ON UPDATE CASCADE ON DELETE RESTRICT,
  role          VARCHAR(50),
  PRIMARY KEY (course_code, instructor_id)
);


CREATE TABLE IF NOT EXISTS course_reviews (
  review_id     INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  course_code   VARCHAR(50) NOT NULL REFERENCES courses(course_code)
                  ON UPDATE CASCADE ON DELETE CASCADE,
  rating        NUMERIC(3,1) NOT NULL CHECK (rating >= 0 AND rating <= 5),
  review_text   TEXT,
  created_at    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);


CREATE INDEX IF NOT EXISTS idx_courses_type           ON courses(type_id);
CREATE INDEX IF NOT EXISTS idx_courses_category       ON courses(category_id);
CREATE INDEX IF NOT EXISTS idx_courses_faculty        ON courses(faculty_group_id);
CREATE INDEX IF NOT EXISTS idx_instructors_name       ON instructors(last_name, first_name);
CREATE INDEX IF NOT EXISTS idx_reviews_course_created ON course_reviews(course_code, created_at DESC);

INSERT INTO course_types(name) VALUES ('กีฬาและนันทนาการ') ON CONFLICT (name) DO NOTHING;
INSERT INTO course_types(name) VALUES ('คณิตศาสตร์') ON CONFLICT (name) DO NOTHING;
INSERT INTO course_types(name) VALUES ('ภาษาอังกฤษ') ON CONFLICT (name) DO NOTHING;
INSERT INTO course_types(name) VALUES ('มนุษย์ศาสตร์') ON CONFLICT (name) DO NOTHING;
INSERT INTO course_types(name) VALUES ('วิทยาศาสตร์') ON CONFLICT (name) DO NOTHING;
INSERT INTO course_types(name) VALUES ('สังคมศาสตร์') ON CONFLICT (name) DO NOTHING;
INSERT INTO course_types(name) VALUES ('เทคโนโลยี') ON CONFLICT (name) DO NOTHING;
INSERT INTO categories(name) VALUES ('การพูด') ON CONFLICT (name) DO NOTHING;
INSERT INTO categories(name) VALUES ('การออกกำลังกาย') ON CONFLICT (name) DO NOTHING;
INSERT INTO categories(name) VALUES ('การอ่าน') ON CONFLICT (name) DO NOTHING;
INSERT INTO categories(name) VALUES ('การเขียน') ON CONFLICT (name) DO NOTHING;
INSERT INTO categories(name) VALUES ('กีฬา') ON CONFLICT (name) DO NOTHING;
INSERT INTO categories(name) VALUES ('คุณธรรม/จริยธรรม') ON CONFLICT (name) DO NOTHING;
INSERT INTO categories(name) VALUES ('คุณภาพชีวิต') ON CONFLICT (name) DO NOTHING;
INSERT INTO categories(name) VALUES ('จิตวิทยา/พฤติกรรม') ON CONFLICT (name) DO NOTHING;
INSERT INTO categories(name) VALUES ('ประยุกต์/เทคโนโลยี') ON CONFLICT (name) DO NOTHING;
INSERT INTO categories(name) VALUES ('พลังงาน/วัสดุ') ON CONFLICT (name) DO NOTHING;
INSERT INTO categories(name) VALUES ('ภาษาเพื่ออาชีพ') ON CONFLICT (name) DO NOTHING;
INSERT INTO categories(name) VALUES ('วิทย์พื้นฐาน') ON CONFLICT (name) DO NOTHING;
INSERT INTO categories(name) VALUES ('วิทย์สุขภาพ') ON CONFLICT (name) DO NOTHING;
INSERT INTO categories(name) VALUES ('วิทย์เทคโนโลยี') ON CONFLICT (name) DO NOTHING;
INSERT INTO categories(name) VALUES ('วิศวกรรมพื้นฐาน') ON CONFLICT (name) DO NOTHING;
INSERT INTO categories(name) VALUES ('สถิติ/วิจัย') ON CONFLICT (name) DO NOTHING;
INSERT INTO categories(name) VALUES ('สังคมวัฒนธรรม') ON CONFLICT (name) DO NOTHING;
INSERT INTO categories(name) VALUES ('สิ่งแวดล้อม/พลังงาน') ON CONFLICT (name) DO NOTHING;
INSERT INTO categories(name) VALUES ('เกม/นันทนาการสังคม') ON CONFLICT (name) DO NOTHING;
INSERT INTO categories(name) VALUES ('เศรษฐศาสตร์/ธุรกิจ') ON CONFLICT (name) DO NOTHING;
INSERT INTO categories(name) VALUES ('ไอที') ON CONFLICT (name) DO NOTHING;
INSERT INTO faculty_groups(name) VALUES ('ทุกคณะ/วิทยาลัย') ON CONFLICT (name) DO NOTHING;
INSERT INTO faculty_groups(name) VALUES ('เฉพาะนานาชาติ') ON CONFLICT (name) DO NOTHING;
INSERT INTO faculty_groups(name) VALUES ('เฉพาะวทอ.') ON CONFLICT (name) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80103011', 'ทักษะการเรียนภาษาอังกฤษ (English Study Skills)', 'ศึกษากลยุทธ์และวิธีการเรียนภาษาอังกฤษอย่างมีประสิทธิภาพ พัฒนาทักษะการฟัง พูด อ่าน เขียน พร้อมทั้งการเรียนรู้ด้วยตนเองและการประเมินผลการเรียนรู้ของตนเอง', (SELECT id FROM course_types WHERE name='ภาษาอังกฤษ'), (SELECT id FROM categories WHERE name='ภาษาเพื่ออาชีพ'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80103018', 'ภาษาอังกฤษเพื่อการทำงาน (English for Work)', 'มุ่งเน้นการใช้ภาษาอังกฤษเพื่อการทำงานจริง ครอบคลุมการเขียนอีเมล จดหมายธุรกิจ การสื่อสารทางการประชุม และการนำเสนอ เพื่อเตรียมความพร้อมสู่โลกอาชีพ', (SELECT id FROM course_types WHERE name='ภาษาอังกฤษ'), (SELECT id FROM categories WHERE name='ภาษาเพื่ออาชีพ'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80103019', 'ภาษาอังกฤษสำหรับนักวิทยาศาสตร์ (English for Scientists)', 'เน้นการใช้ภาษาอังกฤษสำหรับนักวิทยาศาสตร์ ฝึกอ่านบทความวิชาการ การเขียนรายงานวิจัย และการนำเสนอผลงานทางวิทยาศาสตร์', (SELECT id FROM course_types WHERE name='ภาษาอังกฤษ'), (SELECT id FROM categories WHERE name='ภาษาเพื่ออาชีพ'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80103020', 'ภาษาอังกฤษเพื่อการจัดการอุตสาหกรรม (English for Industrial Management)', 'ศึกษาโครงสร้างภาษาอังกฤษที่ใช้ในการจัดการอุตสาหกรรม เช่น การบริหารการผลิต โลจิสติกส์ และคุณภาพ เพื่อการสื่อสารและจัดทำรายงานในระดับสากล', (SELECT id FROM course_types WHERE name='ภาษาอังกฤษ'), (SELECT id FROM categories WHERE name='ภาษาเพื่ออาชีพ'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80103021', 'ภาษาอังกฤษเพื่ออุตสาหกรรมการบริการ (English for Service Industry)', 'เรียนรู้ภาษาอังกฤษที่ใช้ในธุรกิจบริการ เช่น โรงแรม การท่องเที่ยว และงานบริการอื่น ๆ ฝึกทักษะการพูดและการเขียนในสถานการณ์จริง', (SELECT id FROM course_types WHERE name='ภาษาอังกฤษ'), (SELECT id FROM categories WHERE name='ภาษาเพื่ออาชีพ'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80103022', 'การเขียนเพื่ออุตสาหกรรมการบริการ (Writing for Service Industry)', 'ฝึกฝนการเขียนภาษาอังกฤษเพื่อการสื่อสารในงานบริการ เช่น อีเมลธุรกิจ รายงานการบริการ และข้อความประชาสัมพันธ์', (SELECT id FROM course_types WHERE name='ภาษาอังกฤษ'), (SELECT id FROM categories WHERE name='การเขียน'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80103023', 'ภาษาอังกฤษสำหรับวิศวกร (English for Engineers)', 'เน้นภาษาอังกฤษเพื่อการเรียนและทำงานทางวิศวกรรม ฝึกอ่านคู่มือทางเทคนิค เขียนรายงานวิศวกรรม และการนำเสนอผลงาน', (SELECT id FROM course_types WHERE name='ภาษาอังกฤษ'), (SELECT id FROM categories WHERE name='ภาษาเพื่ออาชีพ'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80103028', 'การอ่านเพื่ออุตสาหกรรมการบริการ (Reading for Service Industry)', 'พัฒนาทักษะการอ่านภาษาอังกฤษที่เกี่ยวข้องกับงานบริการ เช่น เอกสารการท่องเที่ยว คู่มือบริการลูกค้า และบทความธุรกิจ', (SELECT id FROM course_types WHERE name='ภาษาอังกฤษ'), (SELECT id FROM categories WHERE name='การอ่าน'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80103029', 'ภาษาอังกฤษสำหรับการท่องเที่ยวและการโรงแรม (English for Tourism and Hotel)', 'ศึกษาการใช้ภาษาอังกฤษเพื่อการสื่อสารด้านการท่องเที่ยวและการโรงแรม เน้นบทสนทนา การเขียนเอกสาร และการแก้ปัญหาเฉพาะหน้า', (SELECT id FROM course_types WHERE name='ภาษาอังกฤษ'), (SELECT id FROM categories WHERE name='ภาษาเพื่ออาชีพ'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80103030', 'การอ่านเชิงวิชาการ (Academic Reading)', 'พัฒนาทักษะการอ่านเชิงวิชาการ วิเคราะห์โครงสร้างบทความวิจัย และสรุปสาระสำคัญเพื่อการศึกษาและงานวิจัย', (SELECT id FROM course_types WHERE name='ภาษาอังกฤษ'), (SELECT id FROM categories WHERE name='การอ่าน'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80103031', 'การอ่านข่าวและเหตุการณ์ปัจจุบัน (News and Current Issues Reading)', 'ฝึกการอ่านและตีความบทความ ข่าวสาร และเหตุการณ์ปัจจุบันเป็นภาษาอังกฤษ เพื่อพัฒนาความเข้าใจและทักษะการคิดวิเคราะห์', (SELECT id FROM course_types WHERE name='ภาษาอังกฤษ'), (SELECT id FROM categories WHERE name='การอ่าน'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80103032', 'การเขียนย่อหน้า (Paragraph Writing)', 'ฝึกการเขียนย่อหน้าอย่างมีโครงสร้าง เน้นการจัดระเบียบความคิด การใช้ไวยากรณ์ที่ถูกต้อง และการเขียนเพื่อการสื่อสารอย่างมีประสิทธิภาพ', (SELECT id FROM course_types WHERE name='ภาษาอังกฤษ'), (SELECT id FROM categories WHERE name='การเขียน'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80103033', 'การเขียนเชิงธุรกิจ (Business Writing)', 'ศึกษาเทคนิคการเขียนภาษาอังกฤษสำหรับงานธุรกิจ เช่น จดหมายธุรกิจ อีเมล รายงาน และข้อเสนอทางธุรกิจ', (SELECT id FROM course_types WHERE name='ภาษาอังกฤษ'), (SELECT id FROM categories WHERE name='การเขียน'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80103034', 'การสนทนาภาษาอังกฤษ (English Conversation)', 'พัฒนาทักษะการสนทนาภาษาอังกฤษในสถานการณ์ต่าง ๆ ทั้งชีวิตประจำวันและวิชาชีพ เน้นความคล่องแคล่วและการใช้ภาษาที่เหมาะสม', (SELECT id FROM course_types WHERE name='ภาษาอังกฤษ'), (SELECT id FROM categories WHERE name='การพูด'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80103035', 'ทักษะการนำเสนอ (Oral Presentation)', 'ฝึกทักษะการนำเสนอเป็นภาษาอังกฤษอย่างเป็นระบบ เน้นการใช้ภาษาที่ชัดเจน การสื่อสารอย่างมั่นใจ และการใช้สื่อประกอบการนำเสนอ', (SELECT id FROM course_types WHERE name='ภาษาอังกฤษ'), (SELECT id FROM categories WHERE name='การพูด'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80103036', 'ภาษาอังกฤษเพื่อการสื่อสารทางสื่อสังคมออนไลน์ (English for Social Media Communication)', 'เรียนรู้การใช้ภาษาอังกฤษสำหรับการสื่อสารบนสื่อสังคมออนไลน์ ครอบคลุมการเขียนโพสต์ การสื่อสารแบบไม่เป็นทางการ และการสร้างภาพลักษณ์เชิงบวก', (SELECT id FROM course_types WHERE name='ภาษาอังกฤษ'), (SELECT id FROM categories WHERE name='ภาษาเพื่ออาชีพ'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80103037', 'วรรณกรรมกระแสนิยมภาษาอังกฤษ (English Popular Literature)', 'ศึกษาและวิเคราะห์วรรณกรรมภาษาอังกฤษร่วมสมัย เพื่อเสริมสร้างทักษะการตีความเชิงวิชาการและการวิจารณ์วรรณกรรม', (SELECT id FROM course_types WHERE name='ภาษาอังกฤษ'), (SELECT id FROM categories WHERE name='การอ่าน'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80103038', 'ภาษาอังกฤษเพื่อการอ่านไพ่ทาโรต์เพื่อการเยียวยา (English for Healing Tarot Reading)', 'เน้นการใช้ภาษาอังกฤษสำหรับการอ่านและอธิบายไพ่ทาโรต์ในเชิงการเยียวยา ฝึกทักษะการสื่อสารเชิงลึกและการใช้ภาษาทางจิตวิญญาณ', (SELECT id FROM course_types WHERE name='ภาษาอังกฤษ'), (SELECT id FROM categories WHERE name='การอ่าน'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80103039', 'ภาษาอังกฤษเพื่อธุรกิจและความเป็นผู้ประกอบการ (English for Business and Entrepreneurship)', 'ฝึกใช้ภาษาอังกฤษในด้านธุรกิจและผู้ประกอบการ เช่น การเขียนแผนธุรกิจ การนำเสนอไอเดีย และการเจรจาต่อรอง', (SELECT id FROM course_types WHERE name='ภาษาอังกฤษ'), (SELECT id FROM categories WHERE name='ภาษาเพื่ออาชีพ'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80103040', 'ภาษาอังกฤษเพื่องานศิลปะและการออกแบบ (English for Art and Design)', 'พัฒนาทักษะภาษาอังกฤษสำหรับงานศิลปะและการออกแบบ เน้นคำศัพท์เชิงเทคนิค การอธิบายผลงาน และการสื่อสารในงานสร้างสรรค์', (SELECT id FROM course_types WHERE name='ภาษาอังกฤษ'), (SELECT id FROM categories WHERE name='ภาษาเพื่ออาชีพ'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80103041', 'ภาษาอังกฤษเพื่องานทรัพยากรมนุษย์ (English for Human Resources)', 'ศึกษาและฝึกใช้ภาษาอังกฤษเพื่อการจัดการทรัพยากรมนุษย์ เช่น การสัมภาษณ์ การสื่อสารภายในองค์กร และเอกสาร HR', (SELECT id FROM course_types WHERE name='ภาษาอังกฤษ'), (SELECT id FROM categories WHERE name='ภาษาเพื่ออาชีพ'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80103042', 'การออกเสียงภาษาอังกฤษ (English Pronunciation)', 'ฝึกการออกเสียงภาษาอังกฤษอย่างถูกต้อง ชัดเจน และเป็นธรรมชาติ เน้นการลดอิทธิพลของสำเนียงท้องถิ่น', (SELECT id FROM course_types WHERE name='ภาษาอังกฤษ'), (SELECT id FROM categories WHERE name='การพูด'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80103043', 'ภาษาอังกฤษเพื่อกิจกรรมสันทนาการ (English for Recreational Activities)', 'เรียนรู้การใช้ภาษาอังกฤษสำหรับกิจกรรมสันทนาการ ฝึกการสนทนา การจัดกิจกรรม และการสื่อสารเพื่อการผ่อนคลาย', (SELECT id FROM course_types WHERE name='ภาษาอังกฤษ'), (SELECT id FROM categories WHERE name='ภาษาเพื่ออาชีพ'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80303201', 'การพูดเพื่อประสิทธิผล (Effective Speech)', 'พัฒนาทักษะการพูดภาษาอังกฤษเพื่อการสื่อสารที่มีประสิทธิภาพ เน้นโครงสร้าง คำศัพท์ และการถ่ายทอดอย่างมั่นใจ', (SELECT id FROM course_types WHERE name='ภาษาอังกฤษ'), (SELECT id FROM categories WHERE name='การพูด'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80103118', 'ลีลาภาษากับความสุนทรีย์ของชีวิต (Language Style and Aesthetics of Life)', 'ศึกษาเรื่องลีลาภาษาและความงามทางวรรณศิลป์ วิเคราะห์การใช้ภาษาในมุมมองวัฒนธรรมและสังคม เพื่อเสริมทักษะการตีความ', (SELECT id FROM course_types WHERE name='ภาษาอังกฤษ'), (SELECT id FROM categories WHERE name='ภาษาเพื่ออาชีพ'), (SELECT id FROM faculty_groups WHERE name='เฉพาะวทอ.'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80103119', 'ภูมิปัญญาไทยในภาษา (Thai Wisdom in Language)', 'ศึกษาองค์ความรู้และภูมิปัญญาไทยที่สะท้อนผ่านภาษา เน้นการทำความเข้าใจรากเหง้าวัฒนธรรมและการใช้ภาษาเชิงลึก', (SELECT id FROM course_types WHERE name='ภาษาอังกฤษ'), (SELECT id FROM categories WHERE name='ภาษาเพื่ออาชีพ'), (SELECT id FROM faculty_groups WHERE name='เฉพาะวทอ.'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80133011', 'ทักษะภาษาอังกฤษเพื่อการนำเสนอ (English Skills for Presentation)', 'ฝึกทักษะภาษาอังกฤษที่จำเป็นสำหรับการนำเสนอ ทั้งการพูด การใช้ภาษากาย และการจัดโครงสร้างเนื้อหาอย่างมืออาชีพ เพื่อการสื่อสารที่มีประสิทธิภาพในระดับวิชาการและธุรกิจ', (SELECT id FROM course_types WHERE name='ภาษาอังกฤษ'), (SELECT id FROM categories WHERE name='การพูด'), (SELECT id FROM faculty_groups WHERE name='เฉพาะนานาชาติ'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80133012', 'ภาษาอังกฤษธุรกิจเพื่อการสื่อสารสำหรับวิศวกร (Business English Communication for Engineers)', 'ศึกษาและฝึกทักษะการใช้ภาษาอังกฤษเชิงธุรกิจที่เกี่ยวข้องกับงานวิศวกรรม เน้นคำศัพท์เฉพาะทาง การเขียนรายงาน การเจรจา และการนำเสนอ เพื่อเตรียมความพร้อมสำหรับการทำงานในสภาพแวดล้อมสากล', (SELECT id FROM course_types WHERE name='ภาษาอังกฤษ'), (SELECT id FROM categories WHERE name='ภาษาเพื่ออาชีพ'), (SELECT id FROM faculty_groups WHERE name='เฉพาะนานาชาติ'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('70153103', 'ทักษะการเขียนภาษาอังกฤษ (English Writing Skills)', 'เรียนรู้หลักการเขียนภาษาอังกฤษเชิงวิชาการและเชิงสื่อสาร ฝึกการเขียนประโยค ย่อหน้า และบทความที่ถูกต้องตามหลักไวยากรณ์และมีประสิทธิภาพ', (SELECT id FROM course_types WHERE name='ภาษาอังกฤษ'), (SELECT id FROM categories WHERE name='การเขียน'), (SELECT id FROM faculty_groups WHERE name='เฉพาะนานาชาติ'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('70153104', 'ทักษะภาษาอังกฤษสำหรับผู้ประกอบการ (English Skills for Entrepreneur)', 'ฝึกทักษะภาษาอังกฤษที่จำเป็นสำหรับผู้ประกอบการ เช่น การเขียนแผนธุรกิจ การนำเสนอแนวคิด การสื่อสารกับนักลงทุนและลูกค้า เพื่อเสริมสร้างขีดความสามารถในการแข่งขันทางธุรกิจ', (SELECT id FROM course_types WHERE name='ภาษาอังกฤษ'), (SELECT id FROM categories WHERE name='ภาษาเพื่ออาชีพ'), (SELECT id FROM faculty_groups WHERE name='เฉพาะนานาชาติ'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('150013105', 'การเขียนเพื่อสื่อสารทางธุรกิจ (Writing for Business Communication)', 'ศึกษาและฝึกการเขียนเอกสารทางธุรกิจ เช่น อีเมล จดหมาย บันทึกข้อความ และรายงาน เพื่อการสื่อสารอย่างมีประสิทธิภาพและเป็นทางการ', (SELECT id FROM course_types WHERE name='ภาษาอังกฤษ'), (SELECT id FROM categories WHERE name='การเขียน'), (SELECT id FROM faculty_groups WHERE name='เฉพาะนานาชาติ'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('150013106', 'การรายงานและการนำเสนอทางธุรกิจ (Business Report Writing and Presentation)', 'เรียนรู้การเขียนรายงานธุรกิจอย่างเป็นระบบ และการนำเสนอข้อมูลเชิงธุรกิจต่อผู้บริหารและผู้มีส่วนได้ส่วนเสีย โดยเน้นความชัดเจนและความน่าเชื่อถือ', (SELECT id FROM course_types WHERE name='ภาษาอังกฤษ'), (SELECT id FROM categories WHERE name='การเขียน'), (SELECT id FROM faculty_groups WHERE name='เฉพาะนานาชาติ'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('40203100', 'คณิตศาสตร์ทั่วไป (General Mathematics)', 'เรียนรู้พื้นฐานทางคณิตศาสตร์ที่ใช้ในชีวิตประจำวัน เช่น การคำนวณ การแก้สมการ และการใช้เหตุผลเชิงตรรกะ', (SELECT id FROM course_types WHERE name='คณิตศาสตร์'), (SELECT id FROM categories WHERE name='ประยุกต์/เทคโนโลยี'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('40203103', 'วิทยาการข้อมูลสำหรับชีวิตประจำวัน (Data Science for Daily Life)', 'ศึกษาแนวคิดพื้นฐานด้านวิทยาการข้อมูล การวิเคราะห์ข้อมูล และการประยุกต์ใช้ในชีวิตประจำวัน', (SELECT id FROM course_types WHERE name='คณิตศาสตร์'), (SELECT id FROM categories WHERE name='ประยุกต์/เทคโนโลยี'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('40503001', 'สถิติในชีวิตประจำวัน (Statistics in Everyday Life)', 'ฝึกการใช้สถิติในชีวิตประจำวัน เช่น การวิเคราะห์ข้อมูล การตีความ และการตัดสินใจจากข้อมูลเชิงปริมาณ', (SELECT id FROM course_types WHERE name='คณิตศาสตร์'), (SELECT id FROM categories WHERE name='สถิติ/วิจัย'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('40503080', 'หลักสถิติ (Fundamentals of Statistics)', 'ศึกษาแนวคิดพื้นฐานทางสถิติ การวิเคราะห์ข้อมูล และการประยุกต์ใช้ในงานวิจัยและวิชาชีพ', (SELECT id FROM course_types WHERE name='คณิตศาสตร์'), (SELECT id FROM categories WHERE name='สถิติ/วิจัย'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('150013140', 'คณิตศาสตร์ทั่วไป (General Mathematics)', 'ศึกษาแนวคิดพื้นฐานทางคณิตศาสตร์ที่จำเป็นต่อการเรียนและการดำรงชีวิต เช่น พีชคณิต เรขาคณิต และสถิติ', (SELECT id FROM course_types WHERE name='คณิตศาสตร์'), (SELECT id FROM categories WHERE name='ประยุกต์/เทคโนโลยี'), (SELECT id FROM faculty_groups WHERE name='เฉพาะนานาชาติ'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('130013003', 'โปรแกรมสำเร็จรูปทางคณิตศาสตร์ (Mathematical Software)', 'เรียนรู้การใช้โปรแกรมสำเร็จรูปทางคณิตศาสตร์ เช่น MATLAB, SPSS หรือ Mathematica เพื่อการแก้ปัญหาและการวิจัย', (SELECT id FROM course_types WHERE name='คณิตศาสตร์'), (SELECT id FROM categories WHERE name='ประยุกต์/เทคโนโลยี'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('130013005', 'สถิติเบื้องต้นสำหรับการวิจัย (Basic Statistics for Research)', 'ศึกษาหลักการทางสถิติที่ใช้ในการวิจัย เช่น การเก็บข้อมูล การแจกแจง ความน่าจะเป็น และการวิเคราะห์ข้อมูลเบื้องต้น', (SELECT id FROM course_types WHERE name='คณิตศาสตร์'), (SELECT id FROM categories WHERE name='สถิติ/วิจัย'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('40113005', 'เคมีในชีวิตประจำวัน (Chemistry in Everyday Life)', 'ศึกษาแนวคิดทางเคมีที่เกี่ยวข้องกับชีวิตประจำวัน เช่น สารเคมีในครัวเรือน อาหาร และสิ่งแวดล้อม', (SELECT id FROM course_types WHERE name='วิทยาศาสตร์'), (SELECT id FROM categories WHERE name='วิทย์พื้นฐาน'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('40313016', 'ฟิสิกส์ในชีวิตประจำวัน (Physics in Daily Life)', 'ศึกษาโครงสร้างและการทำงานของร่างกายมนุษย์ รวมทั้งการดูแลสุขภาพเพื่อการดำรงชีวิตที่ยั่งยืน', (SELECT id FROM course_types WHERE name='คณิตศาสตร์'), (SELECT id FROM categories WHERE name='ประยุกต์/เทคโนโลยี'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('40313018', 'ร่างกายมนุษย์และสุขภาพ (Human Body and Health)', 'ศึกษาโครงสร้างและการทำงานของร่างกายมนุษย์ รวมทั้งการดูแลสุขภาพเพื่อการดำรงชีวิตที่ยั่งยืน', (SELECT id FROM course_types WHERE name='วิทยาศาสตร์'), (SELECT id FROM categories WHERE name='วิทย์สุขภาพ'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('40313019', 'สุขศาสตร์อุตสาหกรรม (Industrial Hygiene)', 'เรียนรู้หลักการด้านสุขศาสตร์อุตสาหกรรม เพื่อการจัดการสิ่งแวดล้อมการทำงานและความปลอดภัยของแรงงาน', (SELECT id FROM course_types WHERE name='วิทยาศาสตร์'), (SELECT id FROM categories WHERE name='วิทย์สุขภาพ'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('40413001', 'ชีววิทยาในชีวิตประจำวัน (Biology in Daily Life)', 'เรียนรู้หลักชีววิทยาที่เกี่ยวข้องกับชีวิตประจำวัน เช่น สุขภาพ สิ่งแวดล้อม และอาหาร', (SELECT id FROM course_types WHERE name='วิทยาศาสตร์'), (SELECT id FROM categories WHERE name='วิทย์พื้นฐาน'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('40423001', 'สิ่งแวดล้อมและพลังงาน (Environment and Energy)', 'ศึกษาแนวคิดด้านสิ่งแวดล้อมและพลังงาน เพื่อการจัดการทรัพยากรและการใช้พลังงานอย่างยั่งยืน', (SELECT id FROM course_types WHERE name='วิทยาศาสตร์'), (SELECT id FROM categories WHERE name='สิ่งแวดล้อม/พลังงาน'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('40423002', 'การจัดการสิ่งแวดล้อมเบื้องต้น (Introduction to Environmental Management)', 'เรียนรู้หลักการจัดการสิ่งแวดล้อมเบื้องต้น เพื่อป้องกันและแก้ไขปัญหาสิ่งแวดล้อมในสังคม', (SELECT id FROM course_types WHERE name='วิทยาศาสตร์'), (SELECT id FROM categories WHERE name='สิ่งแวดล้อม/พลังงาน'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('40433001', 'อาหาร สุขภาพและคุณภาพชีวิต (Food, Health and Quality of Life)', 'ศึกษาโภชนาการและความสัมพันธ์ระหว่างอาหาร สุขภาพ และคุณภาพชีวิต เพื่อการดำรงชีวิตที่ดี', (SELECT id FROM course_types WHERE name='วิทยาศาสตร์'), (SELECT id FROM categories WHERE name='วิทย์สุขภาพ'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('40433002', 'อาหารในชีวิตประจำวัน (Food in Daily Life)', 'เรียนรู้หลักโภชนาการและการเลือกบริโภคอาหารที่เหมาะสมต่อสุขภาพในชีวิตประจำวัน', (SELECT id FROM course_types WHERE name='วิทยาศาสตร์'), (SELECT id FROM categories WHERE name='วิทย์สุขภาพ'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('40713001', 'มนุษย์กับวิทยาศาสตร์กายภาพชีวภาพ (Man Physical Science and Biological Science)', 'ศึกษาแนวคิดทางวิทยาศาสตร์กายภาพและชีวภาพ เพื่อทำความเข้าใจร่างกายมนุษย์และสิ่งแวดล้อม', (SELECT id FROM course_types WHERE name='วิทยาศาสตร์'), (SELECT id FROM categories WHERE name='วิทย์พื้นฐาน'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('40713002', 'วิทยาศาสตร์สุขภาพและโภชนาการ (Healthy Science and Nutrition)', 'เรียนรู้วิทยาศาสตร์สุขภาพและโภชนาการ เพื่อการป้องกันโรคและการสร้างเสริมสุขภาพ', (SELECT id FROM course_types WHERE name='วิทยาศาสตร์'), (SELECT id FROM categories WHERE name='วิทย์สุขภาพ'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('40713003', 'เทคโนโลยีชีวภาพในชีวิตประจำวัน (Biotechnology for Daily Life)', 'ศึกษาการประยุกต์ใช้เทคโนโลยีชีวภาพในชีวิตประจำวัน เพื่อการพัฒนาคุณภาพชีวิตและสังคม', (SELECT id FROM course_types WHERE name='วิทยาศาสตร์'), (SELECT id FROM categories WHERE name='วิทย์เทคโนโลยี'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('40703005', 'สมุนไพรเพื่อสุขภาพ (Herbs for Health)', 'ศึกษาและเรียนรู้สมุนไพรที่ใช้เพื่อการดูแลสุขภาพและการประยุกต์ใช้ในชีวิตประจำวัน', (SELECT id FROM course_types WHERE name='วิทยาศาสตร์'), (SELECT id FROM categories WHERE name='วิทย์สุขภาพ'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('40713006', 'เครื่องสำอางจากธรรมชาติเพื่อสุขภาพ (Natural Medicine for Health)', 'เรียนรู้การใช้ผลิตภัณฑ์จากธรรมชาติเพื่อการส่งเสริมสุขภาพและการป้องกันโรค', (SELECT id FROM course_types WHERE name='วิทยาศาสตร์'), (SELECT id FROM categories WHERE name='วิทย์สุขภาพ'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('40713007', 'ยาจากธรรมชาติเพื่อสุขภาพ (Natural Medicine for Health)', 'ศึกษาการใช้ยาจากธรรมชาติเพื่อการดูแลสุขภาพและการป้องกันโรค', (SELECT id FROM course_types WHERE name='วิทยาศาสตร์'), (SELECT id FROM categories WHERE name='วิทย์สุขภาพ'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('40713008', 'ชีวิตกับเทคโนโลยีชีวภาพสมัยใหม่ (Life and Modern Biotechnology)', 'ศึกษาเทคโนโลยีชีวภาพสมัยใหม่และผลกระทบต่อชีวิต เศรษฐกิจ และสิ่งแวดล้อม', (SELECT id FROM course_types WHERE name='วิทยาศาสตร์'), (SELECT id FROM categories WHERE name='วิทย์เทคโนโลยี'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('40713009', 'ระบบนิเวศและสุขภาพ (Ecosystem and Health)', 'เรียนรู้ความสัมพันธ์ระหว่างระบบนิเวศและสุขภาพ เพื่อการจัดการสิ่งแวดล้อมที่ยั่งยืน', (SELECT id FROM course_types WHERE name='วิทยาศาสตร์'), (SELECT id FROM categories WHERE name='สิ่งแวดล้อม/พลังงาน'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('50113401', 'สิ่งแวดล้อมเพื่อชีวิต (Environment for Life)', 'ศึกษาแนวคิดด้านสิ่งแวดล้อมเพื่อชีวิตและการดำรงอยู่ร่วมกันอย่างสมดุลในธรรมชาติ', (SELECT id FROM course_types WHERE name='วิทยาศาสตร์'), (SELECT id FROM categories WHERE name='สิ่งแวดล้อม/พลังงาน'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('50113402', 'อาหารเพื่อมนุษยชาติ (Food for Humanity)', 'เรียนรู้การจัดการอาหารเพื่อรองรับความต้องการของมนุษยชาติและการพัฒนาที่ยั่งยืน', (SELECT id FROM course_types WHERE name='วิทยาศาสตร์'), (SELECT id FROM categories WHERE name='วิทย์สุขภาพ'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('50113404', 'เครื่องดื่มเพื่อสังคม (Beverages for Society)', 'ศึกษาแนวคิดและการผลิตเครื่องดื่มเพื่อสุขภาพและสังคม', (SELECT id FROM course_types WHERE name='วิทยาศาสตร์'), (SELECT id FROM categories WHERE name='วิทย์สุขภาพ'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('130013002', 'มนุษย์ ระบบนิเวศ และธรรมชาติ (Human, Ecosystem and Nature)', 'ทำความเข้าใจความสัมพันธ์ระหว่างมนุษย์ ระบบนิเวศ และธรรมชาติ เน้นการใช้ทรัพยากรอย่างยั่งยืนและการแก้ปัญหาสิ่งแวดล้อม', (SELECT id FROM course_types WHERE name='วิทยาศาสตร์'), (SELECT id FROM categories WHERE name='สิ่งแวดล้อม/พลังงาน'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('130013006', 'วิทยาศาสตร์และเทคโนโลยีบูรณาการ (Integrated Science and Technology)', 'ศึกษาแนวคิดการบูรณาการวิทยาศาสตร์และเทคโนโลยีจากหลายสาขา เพื่อการแก้ปัญหาและการพัฒนานวัตกรรม', (SELECT id FROM course_types WHERE name='วิทยาศาสตร์'), (SELECT id FROM categories WHERE name='วิทย์พื้นฐาน'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('130013008', 'วิทยาศาสตร์ของเสียงและดนตรี (Science of Sound and Music)', 'ศึกษาหลักการทางวิทยาศาสตร์ของเสียงและดนตรี เช่น คลื่นเสียง ความถี่ และการประยุกต์ใช้ในดนตรีและวิศวกรรมเสียง', (SELECT id FROM course_types WHERE name='วิทยาศาสตร์'), (SELECT id FROM categories WHERE name='วิทย์พื้นฐาน'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('130013010', 'สารพิษในชีวิตประจำวัน (Toxic Substance in Daily Life)', 'เรียนรู้เกี่ยวกับสารพิษที่พบในชีวิตประจำวัน แหล่งที่มา ผลกระทบต่อสุขภาพ และวิธีการป้องกันและจัดการ', (SELECT id FROM course_types WHERE name='วิทยาศาสตร์'), (SELECT id FROM categories WHERE name='วิทย์สุขภาพ'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('130013011', 'วิทยาศาสตร์เพื่อสุขภาพและความงาม (Science for Health and Beauty)', 'ศึกษาหลักการทางวิทยาศาสตร์ที่เกี่ยวข้องกับสุขภาพและความงาม เช่น โภชนาการ การดูแลผิวพรรณ และผลิตภัณฑ์สุขภาพ', (SELECT id FROM course_types WHERE name='วิทยาศาสตร์'), (SELECT id FROM categories WHERE name='วิทย์สุขภาพ'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80203901', 'มนุษย์กับสังคม (Man and Society)', 'ศึกษาเกี่ยวกับความสัมพันธ์ระหว่างมนุษย์กับสังคม บทบาท หน้าที่ และการอยู่ร่วมกันอย่างเข้าใจและเคารพกัน', (SELECT id FROM course_types WHERE name='สังคมศาสตร์'), (SELECT id FROM categories WHERE name='สังคมวัฒนธรรม'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80203902', 'มรดกและอารยธรรมของชาติ (National Heritage and Civilization)', 'เรียนรู้ประวัติศาสตร์ มรดกทางวัฒนธรรม และอารยธรรมที่เป็นรากฐานของชาติ', (SELECT id FROM course_types WHERE name='สังคมศาสตร์'), (SELECT id FROM categories WHERE name='สังคมวัฒนธรรม'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80203903', 'มิติทางสังคม เศรษฐกิจ และการเมือง (Social, Economic and Political Dimensions)', 'ทำความเข้าใจโครงสร้างและความเชื่อมโยงของสังคม เศรษฐกิจ และการเมืองที่ส่งผลต่อชีวิตประจำวัน', (SELECT id FROM course_types WHERE name='สังคมศาสตร์'), (SELECT id FROM categories WHERE name='สังคมวัฒนธรรม'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80203904', 'กฎหมายในชีวิตประจำวัน (Law for Everyday Life)', 'เรียนรู้กฎหมายพื้นฐานที่เกี่ยวข้องกับชีวิตประจำวัน เช่น สัญญา ทรัพย์สิน และสิทธิของประชาชน', (SELECT id FROM course_types WHERE name='สังคมศาสตร์'), (SELECT id FROM categories WHERE name='สังคมวัฒนธรรม'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80203905', 'เศรษฐศาสตร์ในชีวิตประจำวัน (Economics for Everyday Life)', 'ทำความเข้าใจหลักเศรษฐศาสตร์พื้นฐานและการนำไปใช้ในการบริหารเงินและตัดสินใจทางเศรษฐกิจ', (SELECT id FROM course_types WHERE name='สังคมศาสตร์'), (SELECT id FROM categories WHERE name='เศรษฐศาสตร์/ธุรกิจ'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80203906', 'เศรษฐศาสตร์เพื่อการพัฒนาชีวิต (Economics for Life Development)', 'ประยุกต์แนวคิดเศรษฐศาสตร์เพื่อพัฒนาคุณภาพชีวิตและสร้างความมั่นคงทางเศรษฐกิจส่วนบุคคล', (SELECT id FROM course_types WHERE name='สังคมศาสตร์'), (SELECT id FROM categories WHERE name='เศรษฐศาสตร์/ธุรกิจ'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80203907', 'ธุรกิจในชีวิตประจำวัน (Business for Everyday Life)', 'เข้าใจแนวคิดธุรกิจและการบริหารที่เกี่ยวข้องกับชีวิตจริง เช่น การขาย การตลาด และการสร้างรายได้', (SELECT id FROM course_types WHERE name='สังคมศาสตร์'), (SELECT id FROM categories WHERE name='เศรษฐศาสตร์/ธุรกิจ'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80203909', 'เศรษฐกิจ การเมือง และสังคมวัฒนธรรมของประเทศกลุ่มประชาคมอาเซียน (Economic, Political and Socio-Cultural Aspects of ASEAD Counties)', 'ศึกษาความสัมพันธ์ระหว่างประเทศในอาเซียน ทั้งด้านเศรษฐกิจ การเมือง และวัฒนธรรม', (SELECT id FROM course_types WHERE name='สังคมศาสตร์'), (SELECT id FROM categories WHERE name='สังคมวัฒนธรรม'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80203910', 'การต่อต้านการทุจริต (Anti-Corruption)', 'เรียนรู้แนวทางป้องกันและต่อต้านการทุจริต เพื่อเสริมสร้างความโปร่งใสและจริยธรรมในสังคม', (SELECT id FROM course_types WHERE name='สังคมศาสตร์'), (SELECT id FROM categories WHERE name='สังคมวัฒนธรรม'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80203911', 'นวัตกรรมและการพัฒนาเศรษฐกิจ (Innovation and Economic Development)', 'สำรวจบทบาทของนวัตกรรมต่อการขับเคลื่อนเศรษฐกิจและการพัฒนาอย่างยั่งยืน', (SELECT id FROM course_types WHERE name='สังคมศาสตร์'), (SELECT id FROM categories WHERE name='เศรษฐศาสตร์/ธุรกิจ'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80203912', 'เศรษฐศาสตร์ธุรกิจและการจัดการ (Business and Managerial Economics)', 'ประยุกต์หลักเศรษฐศาสตร์เพื่อการตัดสินใจและบริหารจัดการในองค์กรธุรกิจ', (SELECT id FROM course_types WHERE name='สังคมศาสตร์'), (SELECT id FROM categories WHERE name='เศรษฐศาสตร์/ธุรกิจ'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80203918', 'การประเมินความคุ้มค่าโครงการ (Project Evaluation)', 'ศึกษาวิธีการวิเคราะห์และประเมินความคุ้มค่าทางเศรษฐกิจของโครงการต่างๆ', (SELECT id FROM course_types WHERE name='สังคมศาสตร์'), (SELECT id FROM categories WHERE name='เศรษฐศาสตร์/ธุรกิจ'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80203920', 'การจัดการระดับโลก (Global Management)', 'เข้าใจแนวคิดการบริหารในระดับสากลและการจัดการองค์กรในโลกที่เชื่อมต่อกัน', (SELECT id FROM course_types WHERE name='สังคมศาสตร์'), (SELECT id FROM categories WHERE name='เศรษฐศาสตร์/ธุรกิจ'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('802039023', 'การออกแบบประสบการณ์ผู้บริโภค (Consumer Experience Design)', 'เรียนรู้การออกแบบสินค้าและบริการให้ตอบโจทย์ความต้องการและความรู้สึกของผู้บริโภค', (SELECT id FROM course_types WHERE name='สังคมศาสตร์'), (SELECT id FROM categories WHERE name='เศรษฐศาสตร์/ธุรกิจ'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('50213201', 'บทบาทของผู้บริโภคในงานพัฒนาผลิตภัณฑ์ (Consumers Roles in Product Development)', 'ศึกษาอิทธิพลของผู้บริโภคต่อกระบวนการพัฒนาและปรับปรุงผลิตภัณฑ์', (SELECT id FROM course_types WHERE name='สังคมศาสตร์'), (SELECT id FROM categories WHERE name='เศรษฐศาสตร์/ธุรกิจ'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('170313002', 'การบริการที่เป็นเลิศ (Service Excellence)', 'เรียนรู้หลักการสร้างความพึงพอใจและประสบการณ์ที่ดีให้กับลูกค้า', (SELECT id FROM course_types WHERE name='สังคมศาสตร์'), (SELECT id FROM categories WHERE name='เศรษฐศาสตร์/ธุรกิจ'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 2, 2, 5)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80303608', 'ความเป็นพลเมืองกับความรับผิดชอบต่อสังคม (Citizenship and Social Responsibility)', 'ส่งเสริมจิตสำนึกความรับผิดชอบต่อสังคมและการมีส่วนร่วมในฐานะพลเมืองที่ดี', (SELECT id FROM course_types WHERE name='สังคมศาสตร์'), (SELECT id FROM categories WHERE name='สังคมวัฒนธรรม'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80203916', 'การคิดเชิงระบบสำหรับการจัดการและการแก้ปัญหา (Systems Thinking for Management and Problem Solving)', 'ฝึกคิดวิเคราะห์อย่างเป็นระบบเพื่อแก้ปัญหาและพัฒนากระบวนการบริหารจัดการ', (SELECT id FROM course_types WHERE name='สังคมศาสตร์'), (SELECT id FROM categories WHERE name='เศรษฐศาสตร์/ธุรกิจ'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80203916', 'เศรษฐกิจสีเขียว (Green Economy)', 'ทำความเข้าใจเศรษฐกิจที่คำนึงถึงสิ่งแวดล้อมและความยั่งยืน', (SELECT id FROM course_types WHERE name='สังคมศาสตร์'), (SELECT id FROM categories WHERE name='เศรษฐศาสตร์/ธุรกิจ'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80203917', 'วางแผนการเงินและการลงทุนสำหรับเศรษฐกิจดิจิทัล (Financial Planning and Investment in Digital Economy)', 'เรียนรู้การบริหารเงินและการลงทุนในยุคเศรษฐกิจดิจิทัล', (SELECT id FROM course_types WHERE name='สังคมศาสตร์'), (SELECT id FROM categories WHERE name='เศรษฐศาสตร์/ธุรกิจ'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80203919', 'ทฤษฎีเกม (Game Theory)', 'ศึกษาการตัดสินใจเชิงกลยุทธ์ในสถานการณ์แข่งขันและร่วมมือ', (SELECT id FROM course_types WHERE name='สังคมศาสตร์'), (SELECT id FROM categories WHERE name='เศรษฐศาสตร์/ธุรกิจ'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80203921', 'การบริหารการเงินส่วนบุคคลยุคใหม่ (Modern Personal Financial Management)', 'พัฒนาแนวทางจัดการเงินส่วนบุคคลให้เหมาะสมกับชีวิตยุคใหม่', (SELECT id FROM course_types WHERE name='สังคมศาสตร์'), (SELECT id FROM categories WHERE name='เศรษฐศาสตร์/ธุรกิจ'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80303801', 'สายพันธุ์นวัตกร (Innovator''s DNA)', 'เรียนรู้คุณลักษณะและแนวคิดของผู้สร้างนวัตกรรม เพื่อพัฒนาทักษะการคิดสร้างสรรค์', (SELECT id FROM course_types WHERE name='สังคมศาสตร์'), (SELECT id FROM categories WHERE name='เศรษฐศาสตร์/ธุรกิจ'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80303804', 'การทำงานในสังคมพหุวัฒนธรรม (Working in Multicultural Environment)', 'ทำความเข้าใจและปรับตัวในการทำงานร่วมกับผู้คนจากหลากหลายวัฒนธรรม', (SELECT id FROM course_types WHERE name='สังคมศาสตร์'), (SELECT id FROM categories WHERE name='สังคมวัฒนธรรม'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80203915', 'เศรษฐกิจพอเพียงกับการพัฒนาที่ยั่งยืน (Sufficiency Economy and Sustainable Development)', 'ศึกษาแนวคิดเศรษฐกิจพอเพียงและการประยุกต์ใช้เพื่อความยั่งยืนในชีวิตและสังคม', (SELECT id FROM course_types WHERE name='สังคมศาสตร์'), (SELECT id FROM categories WHERE name='เศรษฐศาสตร์/ธุรกิจ'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80203922', 'กฎหมายสิ่งแวดล้อมกับการจัดการสิ่งแวดล้อมอุตสาหกรรม (Environmental Laws and Industrial Environmental Management)', 'เรียนรู้กฎหมายและแนวทางจัดการสิ่งแวดล้อมในภาคอุตสาหกรรมอย่างยั่งยืน', (SELECT id FROM course_types WHERE name='สังคมศาสตร์'), (SELECT id FROM categories WHERE name='เศรษฐศาสตร์/ธุรกิจ'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80203924', 'การจัดการทุนมนุษย์ในองค์การสู่การพัฒนาอย่างยั่งยืน (Human Capital Management for Sustainable Development)', 'ศึกษาการพัฒนาและบริหารทรัพยากรมนุษย์เพื่อความยั่งยืนขององค์กร', (SELECT id FROM course_types WHERE name='สังคมศาสตร์'), (SELECT id FROM categories WHERE name='เศรษฐศาสตร์/ธุรกิจ'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('130013012', 'สถานการณ์สิ่งแวดล้อมในปัจจุบัน (Current Environmental Issues)', 'สำรวจปัญหาและแนวทางแก้ไขสถานการณ์สิ่งแวดล้อมในระดับโลกและท้องถิ่น', (SELECT id FROM course_types WHERE name='สังคมศาสตร์'), (SELECT id FROM categories WHERE name='เศรษฐศาสตร์/ธุรกิจ'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80303611', 'การเรียนรู้ผ่านกิจกรรมนักศึกษา (Learning through Student Activities)', 'ส่งเสริมการเรียนรู้จากประสบการณ์จริงผ่านกิจกรรมนักศึกษาและงานจิตอาสา', (SELECT id FROM course_types WHERE name='สังคมศาสตร์'), (SELECT id FROM categories WHERE name='สังคมวัฒนธรรม'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('70153810', 'กฎหมายในเศรษฐกิจดิจิทัล (Laws in Digital Economy)', 'เรียนรู้กฎหมายที่เกี่ยวข้องกับเทคโนโลยีดิจิทัล เช่น ความเป็นส่วนตัวและธุรกรรมออนไลน์', (SELECT id FROM course_types WHERE name='สังคมศาสตร์'), (SELECT id FROM categories WHERE name='เศรษฐศาสตร์/ธุรกิจ'), (SELECT id FROM faculty_groups WHERE name='เฉพาะนานาชาติ'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('150013126', 'ผู้ประกอบการนวัตกรรม (Inovative Technopreneurs)', 'ศึกษาแนวทางการสร้างธุรกิจโดยใช้เทคโนโลยีและนวัตกรรมเป็นฐาน', (SELECT id FROM course_types WHERE name='สังคมศาสตร์'), (SELECT id FROM categories WHERE name='เศรษฐศาสตร์/ธุรกิจ'), (SELECT id FROM faculty_groups WHERE name='เฉพาะนานาชาติ'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('70153711', 'ทักษะของความเป็นผู้ประกอบการ (Entrepreneurship Skills)', 'พัฒนาทักษะการเป็นผู้ประกอบการ ตั้งแต่การคิดไอเดียจนถึงการดำเนินธุรกิจจริง', (SELECT id FROM course_types WHERE name='สังคมศาสตร์'), (SELECT id FROM categories WHERE name='เศรษฐศาสตร์/ธุรกิจ'), (SELECT id FROM faculty_groups WHERE name='เฉพาะนานาชาติ'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80203908', 'การพัฒนาคุณภาพชีวิตในการทำงานและสังคม (Development of Quality of Life in Work and Socialization)', 'เรียนรู้แนวทางพัฒนาคุณภาพชีวิตให้สมดุลทั้งการทำงานและการอยู่ร่วมกับสังคม', (SELECT id FROM course_types WHERE name='มนุษย์ศาสตร์'), (SELECT id FROM categories WHERE name='คุณภาพชีวิต'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80303803', 'พฤติกรรมนวัตกรรมในการทำงาน (Innovative Work Behavior)', 'ศึกษาการสร้างสรรค์แนวคิดใหม่และการประยุกต์นวัตกรรมในการทำงานอย่างมีประสิทธิภาพ', (SELECT id FROM course_types WHERE name='มนุษย์ศาสตร์'), (SELECT id FROM categories WHERE name='จิตวิทยา/พฤติกรรม'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80303101', 'จิตวิทยาทั่วไป (General Psychology)', 'ทำความเข้าใจพื้นฐานของจิตใจ พฤติกรรม และกระบวนการคิดของมนุษย์', (SELECT id FROM course_types WHERE name='มนุษย์ศาสตร์'), (SELECT id FROM categories WHERE name='จิตวิทยา/พฤติกรรม'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80303103', 'จิตวิทยาเพื่อความสุขในการดำรงชีวิต (Psychology for Happy Life)', 'เรียนรู้แนวทางทางจิตวิทยาในการสร้างความสุขและสมดุลในชีวิต', (SELECT id FROM course_types WHERE name='มนุษย์ศาสตร์'), (SELECT id FROM categories WHERE name='จิตวิทยา/พฤติกรรม'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80303104', 'จิตวิทยาเพื่อการทำงาน (Psychology for Work)', 'ศึกษาการประยุกต์หลักจิตวิทยาเพื่อเพิ่มประสิทธิภาพและแรงจูงใจในการทำงาน', (SELECT id FROM course_types WHERE name='มนุษย์ศาสตร์'), (SELECT id FROM categories WHERE name='จิตวิทยา/พฤติกรรม'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80303102', 'จิตวิทยาสังคม (Social Psychology)', 'ทำความเข้าใจพฤติกรรมของมนุษย์ในบริบททางสังคมและปฏิสัมพันธ์กับผู้อื่น', (SELECT id FROM course_types WHERE name='มนุษย์ศาสตร์'), (SELECT id FROM categories WHERE name='จิตวิทยา/พฤติกรรม'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80303301', 'ศิลปสุนทรีย์ (Art Appreciation)', 'เรียนรู้การรับรู้และชื่นชมคุณค่าความงามของศิลปะในชีวิตประจำวัน', (SELECT id FROM course_types WHERE name='มนุษย์ศาสตร์'), (SELECT id FROM categories WHERE name='คุณภาพชีวิต'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80303601', 'มนุษยสัมพันธ์ (Human Relations)', 'ศึกษาทักษะการสื่อสารและการสร้างความสัมพันธ์ที่ดีระหว่างบุคคลในสังคมและการทำงาน', (SELECT id FROM course_types WHERE name='มนุษย์ศาสตร์'), (SELECT id FROM categories WHERE name='จิตวิทยา/พฤติกรรม'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80303602', 'การพัฒนาคุณภาพชีวิต (Development of Life Quality)', 'เรียนรู้วิธีพัฒนาความเป็นอยู่และความสุขของตนเองทั้งด้านร่างกายและจิตใจ', (SELECT id FROM course_types WHERE name='มนุษย์ศาสตร์'), (SELECT id FROM categories WHERE name='คุณภาพชีวิต'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80303603', 'การพัฒนาบุคลิกภาพ (Personality Development)', 'พัฒนาอิทธิพลทางบุคลิกภาพ ท่าทาง และการสื่อสารให้เหมาะสมกับการทำงานและสังคม', (SELECT id FROM course_types WHERE name='มนุษย์ศาสตร์'), (SELECT id FROM categories WHERE name='คุณภาพชีวิต'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80303606', 'การคิดเชิงระบบและความคิดสร้างสรรรค์ (Systematic and Creative Thinking)', 'ฝึกกระบวนการคิดอย่างเป็นระบบและส่งเสริมความคิดสร้างสรรค์ในการแก้ปัญหา', (SELECT id FROM course_types WHERE name='มนุษย์ศาสตร์'), (SELECT id FROM categories WHERE name='คุณภาพชีวิต'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80303607', 'ความปลอดภัยในชีวิต (Safety Life)', 'เรียนรู้หลักการและแนวทางในการดำรงชีวิตอย่างปลอดภัยในทุกสถานการณ์', (SELECT id FROM course_types WHERE name='มนุษย์ศาสตร์'), (SELECT id FROM categories WHERE name='คุณภาพชีวิต'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80303609', 'สุขภาพเพื่อชีวิต (Healthy Life)', 'ส่งเสริมสุขภาพกายและใจเพื่อคุณภาพชีวิตที่ดีและยั่งยืน', (SELECT id FROM course_types WHERE name='มนุษย์ศาสตร์'), (SELECT id FROM categories WHERE name='คุณภาพชีวิต'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80303610', 'นันทนาการเพื่อชีวิต (Recreation for Life)', 'ศึกษาและฝึกกิจกรรมนันทนาการเพื่อความผ่อนคลายและเสริมสร้างความสุขในชีวิต', (SELECT id FROM course_types WHERE name='มนุษย์ศาสตร์'), (SELECT id FROM categories WHERE name='คุณภาพชีวิต'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('50113405', 'ทักษะด้านอารมณ์ในการทำงาน (Soft Skill for Work)', 'พัฒนาทักษะการจัดการอารมณ์และการทำงานร่วมกับผู้อื่นอย่างมีประสิทธิภาพ', (SELECT id FROM course_types WHERE name='มนุษย์ศาสตร์'), (SELECT id FROM categories WHERE name='จิตวิทยา/พฤติกรรม'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80303802', 'จิตวิทยาดิจิทัล (Digital Psychology)', 'ศึกษาผลกระทบของเทคโนโลยีดิจิทัลต่อพฤติกรรมและจิตใจของมนุษย์', (SELECT id FROM course_types WHERE name='มนุษย์ศาสตร์'), (SELECT id FROM categories WHERE name='จิตวิทยา/พฤติกรรม'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('10013821', 'จริยธรรมในการทำงานและความเป็นมืออาชีพ (Work Ethics and Professionalism)', 'เรียนรู้หลักจริยธรรมและแนวทางการเป็นผู้ประกอบวิชาชีพอย่างมีความรับผิดชอบ', (SELECT id FROM course_types WHERE name='มนุษย์ศาสตร์'), (SELECT id FROM categories WHERE name='คุณธรรม/จริยธรรม'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 2, 1, 2, 3)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('10213702', 'จรรยาบรรณในการประกอบวิชาชีพ (Work Ethics)', 'ศึกษาหลักคุณธรรมและจรรยาบรรณที่ควรมีในการประกอบอาชีพ', (SELECT id FROM course_types WHERE name='มนุษย์ศาสตร์'), (SELECT id FROM categories WHERE name='คุณธรรม/จริยธรรม'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 2, 2, 0, 4)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('20003123', 'จรรยาบรรณวิชาชีพ (Professional Ethics)', 'เรียนรู้มาตรฐานทางจริยธรรมของผู้ประกอบวิชาชีพในด้านต่างๆ', (SELECT id FROM course_types WHERE name='มนุษย์ศาสตร์'), (SELECT id FROM categories WHERE name='คุณธรรม/จริยธรรม'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 1, 1, 0, 2)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('30953115', 'สมาธิเพื่อการพัฒนาชีวิต (Meditation For Life Development)', 'ฝึกสมาธิเพื่อพัฒนาความสงบภายในและเสริมสร้างสมาธิในการใช้ชีวิตและทำงาน', (SELECT id FROM course_types WHERE name='มนุษย์ศาสตร์'), (SELECT id FROM categories WHERE name='คุณภาพชีวิต'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('150013125', 'การเรียนรู้สู่ความเป็นมืออาชีพ (Study as a process into Profession)', 'เรียนรู้แนวทางพัฒนาทักษะและทัศนคติเพื่อเตรียมความพร้อมสู่ความเป็นมืออาชีพ', (SELECT id FROM course_types WHERE name='มนุษย์ศาสตร์'), (SELECT id FROM categories WHERE name='คุณภาพชีวิต'), (SELECT id FROM faculty_groups WHERE name='เฉพาะนานาชาติ'), 2, 2, 0, 4)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('150013142', 'สิ่งแวดล้อมเพื่อชีวิต (Environment for Life)', 'ศึกษาแนวทางการอยู่ร่วมกับสิ่งแวดล้อมอย่างยั่งยืนและสร้างจิตสำนึกในการอนุรักษ์ธรรมชาติ', (SELECT id FROM course_types WHERE name='มนุษย์ศาสตร์'), (SELECT id FROM categories WHERE name='คุณภาพชีวิต'), (SELECT id FROM faculty_groups WHERE name='เฉพาะนานาชาติ'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('150013120', 'มนุษยสัมพันธ์ (Human Relations)', 'เสริมสร้างทักษะความเข้าใจผู้อื่น การทำงานเป็นทีม และการสื่อสารอย่างมีประสิทธิภาพ', (SELECT id FROM course_types WHERE name='มนุษย์ศาสตร์'), (SELECT id FROM categories WHERE name='จิตวิทยา/พฤติกรรม'), (SELECT id FROM faculty_groups WHERE name='เฉพาะนานาชาติ'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('150013122', 'คุณธรรมและจริยธรรมศึกษา (Moral and Ethical Study)', 'เรียนรู้พื้นฐานทางศีลธรรม คุณธรรม และการประยุกต์ใช้ในชีวิตประจำวัน', (SELECT id FROM course_types WHERE name='มนุษย์ศาสตร์'), (SELECT id FROM categories WHERE name='คุณธรรม/จริยธรรม'), (SELECT id FROM faculty_groups WHERE name='เฉพาะนานาชาติ'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('140813901', 'จริยธรรมในการทำงาน (Ethics for Profession)', 'ปลูกฝังจิตสำนึกด้านคุณธรรมและจรรยาบรรณในการปฏิบัติงานอย่างมืออาชีพ', (SELECT id FROM course_types WHERE name='มนุษย์ศาสตร์'), (SELECT id FROM categories WHERE name='คุณธรรม/จริยธรรม'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 1, 1, 0, 2)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('40603002', 'ระบบคอมพิวเตอร์และโปรแกรมประยุกต์ (Computer System and Applications)', 'ศึกษาหลักการทำงานของระบบคอมพิวเตอร์ตั้งแต่ฮาร์ดแวร์ ซอฟต์แวร์ ระบบปฏิบัติการ ไปจนถึงโปรแกรมพื้นฐาน เช่น Word, Excel, PowerPoint', (SELECT id FROM course_types WHERE name='เทคโนโลยี'), (SELECT id FROM categories WHERE name='ไอที'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('40603004', 'พื้นฐานและการประยุกต์เว็บ (Web Fundamental and Application)', 'เรียนรู้โครงสร้างของเว็บไซต์ ภาษา HTML, CSS และแนวคิดเบื้องต้นของการสร้างเว็บ รวมถึงการนำเว็บไปประยุกต์ใช้ เช่น เว็บร้านค้า หรือเว็บแสดงข้อมูล', (SELECT id FROM course_types WHERE name='เทคโนโลยี'), (SELECT id FROM categories WHERE name='ไอที'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('10123801', 'คอมพิวเตอร์ในชีวิตประจำวัน (Computer in Everyday Life)', 'อธิบายบทบาทของคอมพิวเตอร์ในงานประจำวัน เช่น การสื่อสาร การทำธุรกรรม การเรียน และการจัดการข้อมูล เพื่อเข้าใจผลกระทบของเทคโนโลยีต่อชีวิตมนุษย์', (SELECT id FROM course_types WHERE name='เทคโนโลยี'), (SELECT id FROM categories WHERE name='ไอที'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('10123802', 'เทคโนโลยีสารสนเทศและสื่อสารในชีวิตประจำวัน (Information and Communication Technology in Everyday Life)', 'เรียนรู้ระบบสื่อสารข้อมูล เช่น อินเทอร์เน็ต โทรศัพท์มือถือ เครือข่ายไร้สาย และแอปพลิเคชันสื่อสาร เพื่อใช้อย่างปลอดภัยและมีประสิทธิภาพ', (SELECT id FROM course_types WHERE name='เทคโนโลยี'), (SELECT id FROM categories WHERE name='ไอที'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('10123803', 'พื้นฐานสำคัญเพื่อการรู้เชิงตัวเลขและคอมพิวเตอร์ (Basic of Digital and Computer Literacy)', 'สอนทักษะพื้นฐานที่จำเป็นในยุคดิจิทัล เช่น การคิดเชิงตรรกะ การใช้ข้อมูลอย่างมีเหตุผล และความเข้าใจพื้นฐานทางดิจิทัล เพื่อเตรียมพร้อมสู่การทำงานในโลกเทคโนโลยี', (SELECT id FROM course_types WHERE name='เทคโนโลยี'), (SELECT id FROM categories WHERE name='ไอที'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('10313528', 'อุตสาหกรรมและเทคโนโลยีสีเขียว (Industry and Green Technology)', 'เรียนรู้แนวคิดอุตสาหกรรมที่เป็นมิตรต่อสิ่งแวดล้อม การใช้พลังงานสะอาด และการออกแบบกระบวนการผลิตที่ลดผลกระทบต่อโลก', (SELECT id FROM course_types WHERE name='เทคโนโลยี'), (SELECT id FROM categories WHERE name='พลังงาน/วัสดุ'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('20003101', 'คอมพิวเตอร์เพื่อการศึกษาเบื้องต้น (Basic Computer for Education)', 'ศึกษาการใช้คอมพิวเตอร์และซอฟต์แวร์เพื่อการเรียนการสอน เช่น การสร้างสื่อการเรียนรู้ สไลด์ หรือแบบทดสอบออนไลน์', (SELECT id FROM course_types WHERE name='เทคโนโลยี'), (SELECT id FROM categories WHERE name='ไอที'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 2, 1, 2, 3)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('20003102', 'เทคโนโลยีสารสนเทศเบื้องต้น (Basic Information Technology)', 'ทำความเข้าใจระบบสารสนเทศ การจัดการข้อมูล การรักษาความปลอดภัยของข้อมูล และแนวทางใช้เทคโนโลยีสารสนเทศในองค์กร', (SELECT id FROM course_types WHERE name='เทคโนโลยี'), (SELECT id FROM categories WHERE name='ไอที'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('20003103', 'คอมพิวเตอร์และการโปรแกรม (Computer and Programming)', 'เรียนรู้หลักการเขียนโปรแกรมเบื้องต้น เช่น การใช้ภาษาคอมพิวเตอร์ (Python, C, หรืออื่น ๆ) การใช้ตัวแปร เงื่อนไข และการแก้ปัญหาด้วยตรรกะคำนวณ', (SELECT id FROM course_types WHERE name='เทคโนโลยี'), (SELECT id FROM categories WHERE name='ไอที'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('20003104', 'ไฟฟ้าในชีวิตประจำวัน (Electricity in Everyday Life)', 'เข้าใจหลักการทำงานของไฟฟ้าในอุปกรณ์ต่าง ๆ เช่น เครื่องใช้ไฟฟ้าในบ้าน ระบบแสงสว่าง และการใช้ไฟฟ้าอย่างปลอดภัยและประหยัด', (SELECT id FROM course_types WHERE name='เทคโนโลยี'), (SELECT id FROM categories WHERE name='พลังงาน/วัสดุ'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('20003105', 'การถ่ายภาพเบื้องต้น (Basic Photography)', 'ศึกษาหลักการถ่ายภาพ การใช้กล้อง การจัดองค์ประกอบภาพ แสง และเทคนิคการนำเสนอภาพ เพื่อใช้ในงานสื่อหรือการออกแบบ', (SELECT id FROM course_types WHERE name='เทคโนโลยี'), (SELECT id FROM categories WHERE name='ไอที'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('30113206', 'พื้นฐานการเขียนแบบและการจัดการ (Fundamental Drawing and Management)', 'เรียนรู้การเขียนแบบทางเทคนิค เช่น แบบแปลน โครงสร้าง เครื่องจักร รวมถึงแนวคิดการจัดการโครงการเบื้องต้น', (SELECT id FROM course_types WHERE name='เทคโนโลยี'), (SELECT id FROM categories WHERE name='วิศวกรรมพื้นฐาน'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 2, 1, 2, 3)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('40603003', 'จริยธรรมในการใช้งานคอมพิวเตอร์ (Computer Ethics)', 'ศึกษาแนวทางการใช้เทคโนโลยีอย่างมีจริยธรรม เช่น การเคารพลิขสิทธิ์ ความเป็นส่วนตัว การใช้ข้อมูลอย่างถูกต้อง และความรับผิดชอบต่อสังคมดิจิทัล', (SELECT id FROM course_types WHERE name='เทคโนโลยี'), (SELECT id FROM categories WHERE name='ไอที'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('40603005', 'ปัญญาประดิษฐ์กับวิถีชีวิตใหม่ (Artificial Intelligence in Modern Life)', 'เรียนรู้พื้นฐานของ AI เช่น Machine Learning, Chatbot, และระบบแนะนำ (Recommendation System) รวมถึงผลกระทบของ AI ต่อสังคมและอาชีพ', (SELECT id FROM course_types WHERE name='เทคโนโลยี'), (SELECT id FROM categories WHERE name='ไอที'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('61100002', 'กระบวนการคิดเชิงวิศวกรรม (Sense of Engineer)', 'ฝึกกระบวนการคิดแบบวิศวกร — วิเคราะห์ปัญหาอย่างเป็นระบบ วางแผน ออกแบบ และหาทางแก้ปัญหาที่เหมาะสม', (SELECT id FROM course_types WHERE name='เทคโนโลยี'), (SELECT id FROM categories WHERE name='วิศวกรรมพื้นฐาน'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 2, 2, 0, 4)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('70153813', 'กระบวนการคิดเชิงออกแบบ (Design Thinking)', 'เรียนรู้การคิดเชิงออกแบบเพื่อสร้างนวัตกรรม โดยเน้นการเข้าใจผู้ใช้ ทดลองไอเดีย และปรับปรุงอย่างต่อเนื่อง', (SELECT id FROM course_types WHERE name='เทคโนโลยี'), (SELECT id FROM categories WHERE name='วิศวกรรมพื้นฐาน'), (SELECT id FROM faculty_groups WHERE name='เฉพาะนานาชาติ'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('150013121', 'การคิดอย่างสร้างสรรค์และมีระบบ (Systematic and Creative Thinking)', 'ฝึกทักษะการคิดสร้างสรรค์ควบคู่กับการคิดแบบมีเหตุผล เพื่อใช้แก้ปัญหาในงานเทคโนโลยีหรือชีวิตประจำวัน', (SELECT id FROM course_types WHERE name='เทคโนโลยี'), (SELECT id FROM categories WHERE name='วิศวกรรมพื้นฐาน'), (SELECT id FROM faculty_groups WHERE name='เฉพาะนานาชาติ'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('150013124', 'กระบวนการคิดเชิงออกแบบและสร้างสรรค์อย่างมีระบบ (Systematic Creative and Design Thinking)', 'ผสมผสานแนวคิดของการคิดอย่างมีระบบและการคิดสร้างสรรค์ เพื่อพัฒนาแนวทางใหม่ ๆ ในการออกแบบและนวัตกรรม', (SELECT id FROM course_types WHERE name='เทคโนโลยี'), (SELECT id FROM categories WHERE name='วิศวกรรมพื้นฐาน'), (SELECT id FROM faculty_groups WHERE name='เฉพาะนานาชาติ'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('120113701', 'พื้นฐานเทคโนโลยีปิโตรเคมี (Introduction to Petrochemical Technology)', 'เรียนรู้พื้นฐานการผลิตและกระบวนการแปรรูปวัตถุดิบปิโตรเคมี เช่น พลาสติก ปุ๋ย และผลิตภัณฑ์เคมีต่าง ๆ', (SELECT id FROM course_types WHERE name='เทคโนโลยี'), (SELECT id FROM categories WHERE name='พลังงาน/วัสดุ'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('120113702', 'พื้นฐานของหน่วยปฏิบัติการเฉพาะหน่วย (Introduction to Unit Operation)', 'เข้าใจหลักการพื้นฐานของกระบวนการอุตสาหกรรม เช่น การกลั่น การแยก การแลกเปลี่ยนความร้อน ที่ใช้ในโรงงานเคมี', (SELECT id FROM course_types WHERE name='เทคโนโลยี'), (SELECT id FROM categories WHERE name='พลังงาน/วัสดุ'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('120113703', 'นาโนเทคโนโลยีในชีวิตประจำวัน (Nanotechnology in Everyday Life)', 'ศึกษาเทคโนโลยีระดับนาโน เช่น วัสดุนาโนในเครื่องสำอาง ยา หรืออุปกรณ์อิเล็กทรอนิกส์ และผลกระทบต่อชีวิตมนุษย์', (SELECT id FROM course_types WHERE name='เทคโนโลยี'), (SELECT id FROM categories WHERE name='พลังงาน/วัสดุ'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('130013007', 'วัสดุในชีวิตประจำวัน (Materials in Daily Life)', 'ทำความเข้าใจชนิดของวัสดุต่าง ๆ เช่น โลหะ พลาสติก แก้ว และวัสดุผสม รวมถึงการเลือกใช้วัสดุให้เหมาะกับงาน', (SELECT id FROM course_types WHERE name='เทคโนโลยี'), (SELECT id FROM categories WHERE name='พลังงาน/วัสดุ'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('130013013', 'พลังงานและเทคโนโลยีใกล้ตัว (Energy and Technology around us)', 'ศึกษารูปแบบของพลังงาน เช่น ไฟฟ้า แสงอาทิตย์ ลม และเทคโนโลยีที่ใช้ในการผลิตหรือประหยัดพลังงาน', (SELECT id FROM course_types WHERE name='เทคโนโลยี'), (SELECT id FROM categories WHERE name='พลังงาน/วัสดุ'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('130013019', 'การออกแบบเพื่อการนำเสนอ (Data Presentation Design)', 'เรียนรู้เทคนิคการนำเสนอข้อมูลอย่างมีประสิทธิภาพ เช่น การใช้กราฟ แผนภูมิ อินโฟกราฟิก หรือสื่อมัลติมีเดีย', (SELECT id FROM course_types WHERE name='เทคโนโลยี'), (SELECT id FROM categories WHERE name='วิศวกรรมพื้นฐาน'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('120313701', 'วัสดุทั่วไปและการประยุกต์ใช้ (General Materials and Applications)', 'ศึกษาโครงสร้าง คุณสมบัติ และการประยุกต์ใช้วัสดุในอุตสาหกรรม เช่น วัสดุก่อสร้าง วัสดุไฟฟ้า และวัสดุวิศวกรรม', (SELECT id FROM course_types WHERE name='เทคโนโลยี'), (SELECT id FROM categories WHERE name='พลังงาน/วัสดุ'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('120513158', 'การบำรุงรักษายานยนต์ในชีวิตประจำวัน (Automotive Maintenance in Everyday Life)', 'เรียนรู้หลักการดูแลรักษารถยนต์ เช่น การตรวจสภาพ การเปลี่ยนน้ำมัน การดูแลระบบเบรก เพื่อความปลอดภัยและยืดอายุการใช้งาน', (SELECT id FROM course_types WHERE name='เทคโนโลยี'), (SELECT id FROM categories WHERE name='พลังงาน/วัสดุ'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80303401', 'คาราโอเกะ (Karaoke)', 'เรียนรู้การร้องเพลงอย่างมั่นใจ ฝึกการออกเสียง จังหวะ และการแสดงออกทางอารมณ์ เพื่อสร้างความสุข ผ่อนคลาย และพัฒนาทักษะการสื่อสารในสังคม', (SELECT id FROM course_types WHERE name='กีฬาและนันทนาการ'), (SELECT id FROM categories WHERE name='เกม/นันทนาการสังคม'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 1, 0, 2, 1)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80303501', 'บาสเกตบอล (Basketball)', 'ฝึกพื้นฐานการเล่นบาสเกตบอล เช่น การเลี้ยง การส่ง การยิง การป้องกัน และการเล่นเป็นทีม เพื่อเสริมสร้างความแข็งแรง ความเร็ว และความร่วมมือ', (SELECT id FROM course_types WHERE name='กีฬาและนันทนาการ'), (SELECT id FROM categories WHERE name='กีฬา'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 1, 0, 2, 1)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80303502', 'วอลเลย์บอล (Volleyball)', 'เรียนรู้กติกาและเทคนิคการเล่นวอลเลย์บอล ทั้งการเสิร์ฟ รับ ตบ และบล็อก เพื่อพัฒนาทักษะทางร่างกายและการทำงานร่วมกับผู้อื่น', (SELECT id FROM course_types WHERE name='กีฬาและนันทนาการ'), (SELECT id FROM categories WHERE name='กีฬา'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 1, 0, 2, 1)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80303503', 'แบตมินตัน (Badminton)', 'ฝึกการเล่นแบตมินตันทั้งแบบเดี่ยวและคู่ เน้นทักษะการตี การเคลื่อนไหว การวางแผนเกม และการมีน้ำใจนักกีฬา', (SELECT id FROM course_types WHERE name='กีฬาและนันทนาการ'), (SELECT id FROM categories WHERE name='กีฬา'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 1, 0, 2, 1)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80303504', 'ลีลาศ (Dancing)', 'เรียนรู้การเต้นลีลาศเพื่อเสริมบุคลิกภาพ การทรงตัว ความยืดหยุ่น และการเข้าสังคมอย่างสง่างาม', (SELECT id FROM course_types WHERE name='กีฬาและนันทนาการ'), (SELECT id FROM categories WHERE name='เกม/นันทนาการสังคม'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 1, 0, 2, 1)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80303505', 'เทเบิลเทนนิส (Table Tennis)', 'ศึกษากติกาและเทคนิคของปิงปอง ฝึกความเร็ว การตอบสนอง การควบคุมลูก และสมาธิในการแข่งขัน', (SELECT id FROM course_types WHERE name='กีฬาและนันทนาการ'), (SELECT id FROM categories WHERE name='กีฬา'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 1, 0, 2, 1)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80303507', 'ฟุตบอล (Football)', 'ฝึกพื้นฐานการเล่นฟุตบอล เช่น การเลี้ยง ส่ง ยิง และการป้องกัน รวมถึงการทำงานเป็นทีมและกลยุทธ์ในสนาม', (SELECT id FROM course_types WHERE name='กีฬาและนันทนาการ'), (SELECT id FROM categories WHERE name='กีฬา'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 1, 0, 2, 1)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80303515', 'การเดิน-วิ่ง เพื่อสุขภาพ (Walk and Run for Health)', 'ส่งเสริมการออกกำลังกายแบบง่าย ๆ ด้วยการเดินและวิ่ง เพื่อพัฒนาความอดทนของหัวใจ ปอด และสุขภาพโดยรวม', (SELECT id FROM course_types WHERE name='กีฬาและนันทนาการ'), (SELECT id FROM categories WHERE name='การออกกำลังกาย'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 1, 0, 2, 1)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80303516', 'เกมและเพลง (Games and Songs)', 'เรียนรู้การใช้เกมและเพลงเป็นกิจกรรมนันทนาการเพื่อเสริมสร้างความสัมพันธ์ในกลุ่ม การคลายเครียด และความคิดสร้างสรรค์', (SELECT id FROM course_types WHERE name='กีฬาและนันทนาการ'), (SELECT id FROM categories WHERE name='เกม/นันทนาการสังคม'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 1, 0, 2, 1)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80303517', 'การออกกำลังกายและการฝึกด้วยน้ำหนัก (Fitness and Weight Training)', 'ฝึกการใช้เครื่องออกกำลังกายและอุปกรณ์เวทเทรนนิ่ง เพื่อเสริมสร้างกล้ามเนื้อ ความแข็งแรง และสุขภาพร่างกายที่สมดุล', (SELECT id FROM course_types WHERE name='กีฬาและนันทนาการ'), (SELECT id FROM categories WHERE name='การออกกำลังกาย'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 1, 0, 2, 1)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80303518', 'การเต้นแอโรบิกและเต้นคัฟเวอร์ (Aerobic Dance and Cover Dance)', 'เรียนรู้การเต้นตามจังหวะเพลงเพื่อกระตุ้นการเผาผลาญ พัฒนาความยืดหยุ่น และสร้างความมั่นใจในการแสดงออก', (SELECT id FROM course_types WHERE name='กีฬาและนันทนาการ'), (SELECT id FROM categories WHERE name='การออกกำลังกาย'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 1, 0, 2, 1)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80303519', 'กีฬาบริดจ์ (Bridge)', 'ศึกษาหลักการเล่นไพ่บริดจ์ ฝึกการคิดเชิงกลยุทธ์ การคำนวณ และการวางแผนร่วมกับคู่เล่น', (SELECT id FROM course_types WHERE name='กีฬาและนันทนาการ'), (SELECT id FROM categories WHERE name='กีฬา'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 1, 0, 2, 1)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80303520', 'บอร์ดเกม (Board Games)', 'เรียนรู้การเล่นบอร์ดเกมหลากหลายประเภทเพื่อฝึกทักษะการคิด การวางแผน การแก้ปัญหา และการเข้าสังคมอย่างสร้างสรรค์', (SELECT id FROM course_types WHERE name='กีฬาและนันทนาการ'), (SELECT id FROM categories WHERE name='เกม/นันทนาการสังคม'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 1, 0, 2, 1)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80303521', 'อีสปอร์ต (e-Sports)', 'ศึกษาแนวทางการเล่นเกมในเชิงกีฬา ฝึกทักษะการวางกลยุทธ์ การทำงานเป็นทีม และการใช้เทคโนโลยีอย่างมีวินัย', (SELECT id FROM course_types WHERE name='กีฬาและนันทนาการ'), (SELECT id FROM categories WHERE name='เกม/นันทนาการสังคม'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 1, 0, 2, 1)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80303509', 'เปตอง (Pétanque)', 'ฝึกการเล่นกีฬาเปตองที่เน้นความแม่นยำ การคำนวณระยะ และสมาธิ เหมาะสำหรับทุกวัยและการเล่นเป็นกลุ่ม', (SELECT id FROM course_types WHERE name='กีฬาและนันทนาการ'), (SELECT id FROM categories WHERE name='กีฬา'), (SELECT id FROM faculty_groups WHERE name='เฉพาะวทอ.'), 1, 0, 2, 1)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80303510', 'ไท้จี๋/ไท้เก๊ก (Taiji/Taikek)', 'เรียนรู้ศิลปะการเคลื่อนไหวช้า ๆ เพื่อฝึกสมาธิ การหายใจ การทรงตัว และการผ่อนคลายร่างกายอย่างมีสติ', (SELECT id FROM course_types WHERE name='กีฬาและนันทนาการ'), (SELECT id FROM categories WHERE name='การออกกำลังกาย'), (SELECT id FROM faculty_groups WHERE name='เฉพาะวทอ.'), 1, 0, 2, 1)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80303513', '3x3 บาสเกตบอล (3x3 Basketball)', 'ศึกษาเทคนิคการเล่นบาสเกตบอลแบบทีมเล็ก เน้นความเร็ว การตัดสินใจรวดเร็ว และการเล่นเชิงกลยุทธ์', (SELECT id FROM course_types WHERE name='กีฬาและนันทนาการ'), (SELECT id FROM categories WHERE name='กีฬา'), (SELECT id FROM faculty_groups WHERE name='เฉพาะวทอ.'), 1, 0, 2, 1)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80303514', 'ฟุตซอล (Futsal)', 'ฝึกพื้นฐานการเล่นฟุตบอลในสนามเล็ก พัฒนาความคล่องตัว ความเร็ว และการสื่อสารภายในทีม', (SELECT id FROM course_types WHERE name='กีฬาและนันทนาการ'), (SELECT id FROM categories WHERE name='กีฬา'), (SELECT id FROM faculty_groups WHERE name='เฉพาะวทอ.'), 1, 0, 2, 1)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80303522', 'หมากรุกไทย (Thai Chess)', 'ศึกษากติกาและกลยุทธ์ของหมากรุกไทย ฝึกการวิเคราะห์ การวางแผนล่วงหน้า และความอดทนทางจิตใจ', (SELECT id FROM course_types WHERE name='กีฬาและนันทนาการ'), (SELECT id FROM categories WHERE name='เกม/นันทนาการสังคม'), (SELECT id FROM faculty_groups WHERE name='เฉพาะวทอ.'), 1, 0, 2, 1)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80303523', 'หมากรุกสากล (Chess)', 'เรียนรู้การเล่นหมากรุกแบบสากลเพื่อฝึกการคิดเชิงตรรกะ การวางแผน และการตัดสินใจภายใต้แรงกดดัน', (SELECT id FROM course_types WHERE name='กีฬาและนันทนาการ'), (SELECT id FROM categories WHERE name='เกม/นันทนาการสังคม'), (SELECT id FROM faculty_groups WHERE name='เฉพาะวทอ.'), 1, 0, 2, 1)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80303524', 'หมากรุกจีน (Chinese Chess)', 'ศึกษาเกมหมากรุกแบบจีน ฝึกการใช้กลยุทธ์ การคาดการณ์ และการอ่านเกมของคู่ต่อสู้', (SELECT id FROM course_types WHERE name='กีฬาและนันทนาการ'), (SELECT id FROM categories WHERE name='เกม/นันทนาการสังคม'), (SELECT id FROM faculty_groups WHERE name='เฉพาะวทอ.'), 1, 0, 2, 1)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80303525', 'สกา (Ska)', 'เรียนรู้กติกาและการเล่นเกมสกา ฝึกทักษะการคิด การวางแผน และความสามารถในการปรับตัวตามสถานการณ์', (SELECT id FROM course_types WHERE name='กีฬาและนันทนาการ'), (SELECT id FROM categories WHERE name='เกม/นันทนาการสังคม'), (SELECT id FROM faculty_groups WHERE name='เฉพาะวทอ.'), 1, 0, 2, 1)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('40313017', 'ทักษะการออกกำลังกายและกีฬา (Exercise Skill and Sport)', 'ฝึกพื้นฐานการออกกำลังกายอย่างถูกวิธี การใช้ร่างกายให้เหมาะสม และพัฒนาทักษะกีฬาเบื้องต้นเพื่อสุขภาพ', (SELECT id FROM course_types WHERE name='กีฬาและนันทนาการ'), (SELECT id FROM categories WHERE name='การออกกำลังกาย'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80303526', 'กีฬากับการพัฒนาชีวิต (Sports and Lifestyle Development)', 'เรียนรู้บทบาทของกีฬาในการเสริมสร้างวินัย ความรับผิดชอบ และสุขภาพจิตที่ดี เพื่อพัฒนาคุณภาพชีวิต', (SELECT id FROM course_types WHERE name='กีฬาและนันทนาการ'), (SELECT id FROM categories WHERE name='การออกกำลังกาย'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80303527', 'การท่องเที่ยวเชิงสุขภาพและกีฬา (Wellness Tourism and Sports)', 'ศึกษาแนวคิดการท่องเที่ยวเชิงสุขภาพ เช่น เดินป่า ปีนเขา ปั่นจักรยาน เพื่อส่งเสริมสุขภาพกายและใจ', (SELECT id FROM course_types WHERE name='กีฬาและนันทนาการ'), (SELECT id FROM categories WHERE name='เกม/นันทนาการสังคม'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('80303528', 'การจัดการค่ายพักแรม (Camp Management)', 'เรียนรู้การวางแผน จัดการ และดำเนินกิจกรรมค่าย ฝึกภาวะผู้นำ การทำงานเป็นทีม และการเอาตัวรอดในธรรมชาติ', (SELECT id FROM course_types WHERE name='กีฬาและนันทนาการ'), (SELECT id FROM categories WHERE name='เกม/นันทนาการสังคม'), (SELECT id FROM faculty_groups WHERE name='ทุกคณะ/วิทยาลัย'), 3, 3, 0, 6)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('60434032', 'นันทนาการและการเข้าสังคม (Recreation and Socialization)', 'ศึกษากิจกรรมนันทนาการที่ช่วยเสริมความสัมพันธ์ระหว่างบุคคล การสื่อสาร และการสร้างบรรยากาศเชิงบวกในสังคม', (SELECT id FROM course_types WHERE name='กีฬาและนันทนาการ'), (SELECT id FROM categories WHERE name='เกม/นันทนาการสังคม'), (SELECT id FROM faculty_groups WHERE name='เฉพาะวทอ.'), 1, 0, 2, 1)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('150013163', 'ศิลปะการป้องกันตัว (Self-Defense)', 'เรียนรู้เทคนิคการป้องกันตัวเบื้องต้น เช่น การหลีกเลี่ยง การปัดป้อง และการควบคุมตัวคู่ต่อสู้ เพื่อเสริมความมั่นใจและความปลอดภัยในชีวิตประจำวัน', (SELECT id FROM course_types WHERE name='กีฬาและนันทนาการ'), (SELECT id FROM categories WHERE name='การออกกำลังกาย'), (SELECT id FROM faculty_groups WHERE name='เฉพาะนานาชาติ'), 1, 0, 2, 1)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO courses(course_code, title_th, description_th, type_id, category_id, faculty_group_id, credits, theory_hours, lab_hours, self_study_hours)
VALUES ('150013164', 'กอล์ฟเพื่อสุขภาพ (Golf for Health)', 'เรียนรู้พื้นฐานการเล่นกอล์ฟอย่างถูกวิธี ฝึกสมาธิ การวางแผน การควบคุมร่างกาย และการผ่อนคลายอย่างมีสไตล์', (SELECT id FROM course_types WHERE name='กีฬาและนันทนาการ'), (SELECT id FROM categories WHERE name='กีฬา'), (SELECT id FROM faculty_groups WHERE name='เฉพาะนานาชาติ'), 1, 0, 2, 1)
ON CONFLICT (course_code) DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES (NULL, 'Assoc.', 'Prof. Dr. Emily Ratanachai')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES (NULL, 'Assoc.', 'Prof. Dr. Olivia Thanawan')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES (NULL, 'Assoc.', 'Prof. Dr. Sophia Kittinan')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES (NULL, 'Asst.', 'Prof. Dr. Daniel Phasuk')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES (NULL, 'Asst.', 'Prof. Dr. Jonathan Meesiri')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES (NULL, 'Asst.', 'Prof. Dr. Kevin Rattanapong')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ผศ.', 'กนกพร', 'รัตนโสภณ')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ผศ.', 'กัญญาณัฐ', 'มณีวงศ์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ผศ.', 'กิตติเดช', 'จิระพานิช')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ผศ.', 'จิรายุ', 'บุญเพ็ง')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ผศ.', 'จุฑารัตน์', 'เจริญกุล')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ผศ.', 'ฐิติพร', 'มงคลสิทธิ์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ผศ.', 'ณัฐวดี', 'เจนกิจ')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ผศ.', 'ธิดาวรรณ', 'กาญจนรักษ์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ผศ.', 'ธีรพล', 'โชติธรรม')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ผศ.', 'นเรศ', 'ปัญญาวงศ์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ผศ.', 'ปริญญา', 'เกษมรัตน์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ผศ.', 'ปิยะดา', 'มงคลกิจ')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ผศ.', 'ปิยะดา', 'สุนทรวัฒน์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ผศ.', 'พงษ์พันธุ์', 'ธนกาญจน์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ผศ.', 'ภัทรพงศ์', 'โสภณรัตน์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ผศ.', 'มณีรัตน์', 'บุญญาภิรมย์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ผศ.', 'รัตติยา', 'เจนกิจ')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ผศ.', 'วศิน', 'เกษมศักดิ์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ผศ.', 'ศุภวัฒน์', 'มณีศักดิ์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ผศ.', 'อัญชัน', 'สุทธากร')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ผศ.', 'อัญญารัตน์', 'พานิชวัฒน์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ผศ.ดร.', 'กฤติเดช', 'จิรพัฒน์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ผศ.ดร.', 'กิตติภพ', 'เจริญกุล')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ผศ.ดร.', 'ขวัญใจ', 'อนันต์กุล')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ผศ.ดร.', 'จตุรภัทร', 'ปัญญาวงศ์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ผศ.ดร.', 'ฐิติพร', 'พงศ์มณี')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ผศ.ดร.', 'ณัฐพงศ์', 'วรางค์ไพศาล')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ผศ.ดร.', 'ณัฐพล', 'จันทนกูล')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ผศ.ดร.', 'ณัฐวุฒิ', 'มงคลสุข')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ผศ.ดร.', 'ปริญญา', 'วัฒนะสถิตย์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ผศ.ดร.', 'ปรียาภรณ์', 'จารุวัฒนะ')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ผศ.ดร.', 'ปุณยวีร์', 'พงศ์ประเสริฐ')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ผศ.ดร.', 'มธุรส', 'รัตนกาญจน์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ผศ.ดร.', 'รัตนาภรณ์', 'มณีสุวรรณ')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ผศ.ดร.', 'วริศ', 'สุทธากร')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ผศ.ดร.', 'วิภาวดี', 'พงศ์ประเสริฐ')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ผศ.ดร.', 'อรพิน', 'จิรพัฒน์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ผศ.ดร.', 'อัครพล', 'ธนานนท์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ผศ.ดร.', 'อัญชัน', 'พานิชกิจ')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ผศ.ดร.', 'อัญมณี', 'สุทธิกุล')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ผศ.ดร.', 'อัมพิกา', 'สุทธิวัฒน์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ผศ.ดร.', 'เกียรติศักดิ์', 'รัตนกาญจน์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('รศ.', 'กวินทร์', 'มณีโชติ')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('รศ.', 'กัญญา', 'วรวุฒิ')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('รศ.', 'กิตติเดช', 'สุทธิวัฒน์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('รศ.', 'จตุพร', 'เกษมกิจ')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('รศ.', 'ชนิกานต์', 'เจริญสิน')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('รศ.', 'ชลธิชา', 'เจริญศรี')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('รศ.', 'ชลธิชา', 'เจริญสุข')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('รศ.', 'ธนโชติ', 'พัฒนเดช')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('รศ.', 'นฤมล', 'วัฒนพงศ์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('รศ.', 'ปกรณ์', 'ภูมิพัฒน์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('รศ.', 'ปาริณี', 'วรวุฒิ')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('รศ.', 'ปิยะวัฒน์', 'พัฒนวงศ์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('รศ.', 'ปิยะวัฒน์', 'สุนทรพงศ์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('รศ.', 'พิชญา', 'สิริรัตน์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('รศ.', 'วรรณิศา', 'ธนานนท์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('รศ.', 'วารุณี', 'ปิ่นแก้ว')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('รศ.', 'ศิริวัฒน์', 'เกษมศักดิ์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('รศ.', 'ศุภกร', 'มงคลกิจ')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('รศ.', 'สิทธิโชค', 'เจริญสิน')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('รศ.', 'อัญญารัตน์', 'มณีศักดิ์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('รศ.', 'อัญญารัตน์', 'ศรีวัฒน์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('รศ.', 'อัมพิกา', 'นิลวรรณ')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('รศ.', 'อุไรวรรณ', 'ปัญญาวงศ์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('รศ.', 'เบญจวรรณ', 'เจริญกุล')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('รศ.ดร.', 'กวินทร์', 'ศิริมาศ')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('รศ.ดร.', 'กวินทร์', 'เจนกิจ')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('รศ.ดร.', 'กิตติภูมิ', 'วงศ์นที')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('รศ.ดร.', 'ฐิติรัตน์', 'เจริญวงศ์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('รศ.ดร.', 'ณัฐวุฒิ', 'ศุภกิจ')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('รศ.ดร.', 'ธนาพร', 'วรเศรษฐ์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('รศ.ดร.', 'ธิดารัตน์', 'โสภณชัย')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('รศ.ดร.', 'ธิดาวรรณ', 'ศุภเดช')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('รศ.ดร.', 'นฤมล', 'วรเศรษฐ์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('รศ.ดร.', 'ภูมิรัตน์', 'จิรเดช')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('รศ.ดร.', 'วรวิทย์', 'ศรีพิพัฒน์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('รศ.ดร.', 'วรเมธ', 'อุดมทรัพย์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('รศ.ดร.', 'วิชญา', 'อินทรสกุล')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('รศ.ดร.', 'ศราวุธ', 'อินทรวิชัย')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('รศ.ดร.', 'ศศิธร', 'พิพัฒน์ธนกุล')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('รศ.ดร.', 'ศิริชัย', 'รุ่งอรุณ')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('รศ.ดร.', 'ศุภวัฒน์', 'อินทรากูล')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('รศ.ดร.', 'อรทัย', 'วัฒนบวร')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('รศ.ดร.', 'อัญชลี', 'พงศ์สวัสดิ์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('รศ.ดร.', 'อาภรณ์', 'ทองอยู่')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('รศ.ดร.', 'เบญจวรรณ', 'อินทรรักษ์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ศ.', 'กัญญาณัฐ', 'พงศ์วัฒน์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ศ.', 'คเชนทร์', 'วัฒนบวร')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ศ.', 'จิราภัทร', 'วัฒนะกุล')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ศ.', 'ชนิกานต์', 'จารุพงษ์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ศ.', 'ชนิกานต์', 'ภักดีวงศ์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ศ.', 'ธนาพร', 'ศรีมงคล')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ศ.', 'ปิยะกุล', 'พีรศักดิ์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ศ.', 'พัชราภรณ์', 'ศรีประเสริฐ')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ศ.', 'ลลิตา', 'จิรพงศ์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ศ.', 'วรวิทย์', 'ปิ่นทอง')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ศ.', 'วิไลรัตน์', 'ศิริวัฒน์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ศ.', 'ศุภวัฒน์', 'ศรีมงคล')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ศ.', 'สุพัตรา', 'เศรษฐธรรม')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ศ.', 'สุรเดช', 'ศรีไพบูลย์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ศ.', 'อนุชา', 'รัตนพฤกษ์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ศ.', 'อนุวัฒน์', 'รัตนกาญจน์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ศ.', 'อรพิน', 'จิรเดช')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ศ.', 'อาภรณ์', 'เจริญสุข')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ศ.ดร.', 'คเชนทร์', 'ทองสิทธิ์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ศ.ดร.', 'คเชนทร์', 'มณีโชติ')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ศ.ดร.', 'ชัชวาล', 'กาญจนรักษ์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ศ.ดร.', 'ธนาพร', 'โชติธรรม')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ศ.ดร.', 'ธิดาวรรณ', 'ศรีพิพัฒน์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ศ.ดร.', 'ธิดาวรรณ', 'เกษมรัตน์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ศ.ดร.', 'นภัสสร', 'ศิริพรหม')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ศ.ดร.', 'ปาริณี', 'เศรษฐธรรม')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ศ.ดร.', 'ปิยวัฒน์', 'ศิริมาศ')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ศ.ดร.', 'พัชรี', 'มงคลชัย')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ศ.ดร.', 'พิมพ์ลดา', 'สกุลไทย')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ศ.ดร.', 'รัตติยา', 'รัตนพฤกษ์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ศ.ดร.', 'วรารัตน์', 'พีระเดช')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ศ.ดร.', 'ศรายุทธ', 'มงคลสุข')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ศ.ดร.', 'ศราวุธ', 'ชูเกียรติ')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ศ.ดร.', 'สมบัติ', 'ศรีสมบัติ')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ศ.ดร.', 'อรพรรณ', 'วัฒนะกุล')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES ('ศ.ดร.', 'อรอนงค์', 'โสภณชัย')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES (NULL, 'อาจารย์', 'จตุพร ธนเดช')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES (NULL, 'อาจารย์', 'จตุรภัทร เจนกิจ')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES (NULL, 'อาจารย์', 'จารุวัฒน์ พานิชโยธิน')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES (NULL, 'อาจารย์', 'จิราภัทร มณีวงศ์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES (NULL, 'อาจารย์', 'ดร. กมลชนก ศรีสุนทร')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES (NULL, 'อาจารย์', 'ดร. กิตติทัต เกษมศักดิ์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES (NULL, 'อาจารย์', 'ดร. กิตติพันธ์ ธนวัฒนะ')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES (NULL, 'อาจารย์', 'ดร. ชนิกานต์ ศรีสวัสดิ์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES (NULL, 'อาจารย์', 'ดร. ณัฐวดี จันทรกุล')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES (NULL, 'อาจารย์', 'ดร. ปฐมพงษ์ รุ่งอรุณ')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES (NULL, 'อาจารย์', 'ดร. ปรียาภรณ์ ภักดีวงศ์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES (NULL, 'อาจารย์', 'ดร. ปวริศ ทองมาก')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES (NULL, 'อาจารย์', 'ดร. ปิยวัฒน์ สุทธิสกุล')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES (NULL, 'อาจารย์', 'ดร. ปิยะชาติ จันทรกุล')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES (NULL, 'อาจารย์', 'ดร. พงษ์ศิริ วรรณพงศ์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES (NULL, 'อาจารย์', 'ดร. พิมพ์อร พัฒนเดช')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES (NULL, 'อาจารย์', 'ดร. มธุรส มงคลสุข')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES (NULL, 'อาจารย์', 'ดร. มาริสา ศรีมงคล')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES (NULL, 'อาจารย์', 'ดร. วินัย ภักดีวัฒน์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES (NULL, 'อาจารย์', 'ดร. ศราวุธ จิรสมบัติ')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES (NULL, 'อาจารย์', 'ดร. อัมพิกา พงศ์มณี')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES (NULL, 'อาจารย์', 'ดร. อาภาพร วรรณพงศ์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES (NULL, 'อาจารย์', 'ธีรเดช วัฒนะกุล')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES (NULL, 'อาจารย์', 'ปฐมพงษ์ มงคลสิทธิ์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES (NULL, 'อาจารย์', 'ปรียาภรณ์ อินทรากูล')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES (NULL, 'อาจารย์', 'พงษ์ศิริ มณีศิริ')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES (NULL, 'อาจารย์', 'พนมกร ภักดีชัย')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES (NULL, 'อาจารย์', 'วรรณิศา กาญจนรักษ์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES (NULL, 'อาจารย์', 'วรเทพ ทองมี')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES (NULL, 'อาจารย์', 'วรเมธ จิตตะกุล')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES (NULL, 'อาจารย์', 'วินัย ปัญญาวงศ์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES (NULL, 'อาจารย์', 'สิทธิโชค ศรีสวัสดิ์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES (NULL, 'อาจารย์', 'อนิรุทธิ์ ปัญญานนท์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES (NULL, 'อาจารย์', 'อรพิน พงษ์ศิริ')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES (NULL, 'อาจารย์', 'อรอนงค์ สุนทรวัฒน์')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES (NULL, 'อาจารย์', 'อัญญารัตน์ บุญมาก')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO instructors(title, first_name, last_name)
VALUES (NULL, 'อาจารย์', 'อุไรวรรณ โชติธรรม')
ON CONFLICT ON CONSTRAINT uq_instructor_min DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80103011', id FROM instructors
 WHERE first_name='วริศ' AND last_name='สุทธากร'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80103018', id FROM instructors
 WHERE first_name='รัตติยา' AND last_name='รัตนพฤกษ์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80103019', id FROM instructors
 WHERE first_name='อัญชัน' AND last_name='สุทธากร'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80103020', id FROM instructors
 WHERE first_name='อาจารย์' AND last_name='ปฐมพงษ์ มงคลสิทธิ์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80103021', id FROM instructors
 WHERE first_name='กิตติภูมิ' AND last_name='วงศ์นที'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80103022', id FROM instructors
 WHERE first_name='อาจารย์' AND last_name='อัญญารัตน์ บุญมาก'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80103023', id FROM instructors
 WHERE first_name='อาจารย์' AND last_name='อรอนงค์ สุนทรวัฒน์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80103028', id FROM instructors
 WHERE first_name='กัญญา' AND last_name='วรวุฒิ'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80103029', id FROM instructors
 WHERE first_name='ศุภกร' AND last_name='มงคลกิจ'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80103030', id FROM instructors
 WHERE first_name='ปาริณี' AND last_name='เศรษฐธรรม'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80103031', id FROM instructors
 WHERE first_name='สุพัตรา' AND last_name='เศรษฐธรรม'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80103032', id FROM instructors
 WHERE first_name='อัมพิกา' AND last_name='นิลวรรณ'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80103033', id FROM instructors
 WHERE first_name='ปาริณี' AND last_name='วรวุฒิ'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80103034', id FROM instructors
 WHERE first_name='ธิดารัตน์' AND last_name='โสภณชัย'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80103035', id FROM instructors
 WHERE first_name='ฐิติพร' AND last_name='มงคลสิทธิ์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80103036', id FROM instructors
 WHERE first_name='อาจารย์' AND last_name='วรเมธ จิตตะกุล'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80103037', id FROM instructors
 WHERE first_name='อาจารย์' AND last_name='ดร. ปิยะชาติ จันทรกุล'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80103038', id FROM instructors
 WHERE first_name='ฐิติพร' AND last_name='มงคลสิทธิ์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80103039', id FROM instructors
 WHERE first_name='ปิยะดา' AND last_name='สุนทรวัฒน์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80103040', id FROM instructors
 WHERE first_name='อาจารย์' AND last_name='ดร. อัมพิกา พงศ์มณี'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80103041', id FROM instructors
 WHERE first_name='ศิริชัย' AND last_name='รุ่งอรุณ'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80103042', id FROM instructors
 WHERE first_name='พิมพ์ลดา' AND last_name='สกุลไทย'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80103043', id FROM instructors
 WHERE first_name='ฐิติพร' AND last_name='พงศ์มณี'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80303201', id FROM instructors
 WHERE first_name='กิตติเดช' AND last_name='จิระพานิช'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80103118', id FROM instructors
 WHERE first_name='อนุชา' AND last_name='รัตนพฤกษ์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80103119', id FROM instructors
 WHERE first_name='อัญชัน' AND last_name='พานิชกิจ'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80133011', id FROM instructors
 WHERE first_name='อาจารย์' AND last_name='จิราภัทร มณีวงศ์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80133012', id FROM instructors
 WHERE first_name='ณัฐพล' AND last_name='จันทนกูล'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '70153103', id FROM instructors
 WHERE first_name='ศุภวัฒน์' AND last_name='ศรีมงคล'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '70153104', id FROM instructors
 WHERE first_name='ศุภวัฒน์' AND last_name='มณีศักดิ์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '150013105', id FROM instructors
 WHERE first_name='อาจารย์' AND last_name='วรเทพ ทองมี'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '150013106', id FROM instructors
 WHERE first_name='อัมพิกา' AND last_name='นิลวรรณ'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '40203100', id FROM instructors
 WHERE first_name='ธิดาวรรณ' AND last_name='กาญจนรักษ์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '40203103', id FROM instructors
 WHERE first_name='อาจารย์' AND last_name='ดร. วินัย ภักดีวัฒน์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '40503001', id FROM instructors
 WHERE first_name='จุฑารัตน์' AND last_name='เจริญกุล'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '40503080', id FROM instructors
 WHERE first_name='คเชนทร์' AND last_name='วัฒนบวร'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '150013140', id FROM instructors
 WHERE first_name='กัญญาณัฐ' AND last_name='พงศ์วัฒน์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '130013003', id FROM instructors
 WHERE first_name='อาภรณ์' AND last_name='ทองอยู่'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '130013005', id FROM instructors
 WHERE first_name='อาจารย์' AND last_name='ดร. มาริสา ศรีมงคล'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '40113005', id FROM instructors
 WHERE first_name='อาจารย์' AND last_name='ดร. พิมพ์อร พัฒนเดช'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '40313016', id FROM instructors
 WHERE first_name='อาจารย์' AND last_name='ดร. ศราวุธ จิรสมบัติ'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '40313018', id FROM instructors
 WHERE first_name='อาจารย์' AND last_name='ดร. ศราวุธ จิรสมบัติ'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '40313019', id FROM instructors
 WHERE first_name='พงษ์พันธุ์' AND last_name='ธนกาญจน์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '40413001', id FROM instructors
 WHERE first_name='Asst.' AND last_name='Prof. Dr. Daniel Phasuk'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '40423001', id FROM instructors
 WHERE first_name='Assoc.' AND last_name='Prof. Dr. Emily Ratanachai'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '40423002', id FROM instructors
 WHERE first_name='Asst.' AND last_name='Prof. Dr. Jonathan Meesiri'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '40433001', id FROM instructors
 WHERE first_name='ณัฐวุฒิ' AND last_name='ศุภกิจ'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '40433002', id FROM instructors
 WHERE first_name='สมบัติ' AND last_name='ศรีสมบัติ'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '40713001', id FROM instructors
 WHERE first_name='ภูมิรัตน์' AND last_name='จิรเดช'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '40713002', id FROM instructors
 WHERE first_name='ศุภวัฒน์' AND last_name='อินทรากูล'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '40713003', id FROM instructors
 WHERE first_name='อรพรรณ' AND last_name='วัฒนะกุล'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '40703005', id FROM instructors
 WHERE first_name='อาจารย์' AND last_name='ดร. กิตติทัต เกษมศักดิ์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '40713006', id FROM instructors
 WHERE first_name='ณัฐวุฒิ' AND last_name='มงคลสุข'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '40713007', id FROM instructors
 WHERE first_name='อรพิน' AND last_name='จิรเดช'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '40713008', id FROM instructors
 WHERE first_name='ศรายุทธ' AND last_name='มงคลสุข'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '40713009', id FROM instructors
 WHERE first_name='อาจารย์' AND last_name='ปรียาภรณ์ อินทรากูล'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '50113401', id FROM instructors
 WHERE first_name='สุรเดช' AND last_name='ศรีไพบูลย์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '50113402', id FROM instructors
 WHERE first_name='ชลธิชา' AND last_name='เจริญศรี'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '50113404', id FROM instructors
 WHERE first_name='มธุรส' AND last_name='รัตนกาญจน์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '130013002', id FROM instructors
 WHERE first_name='นฤมล' AND last_name='วัฒนพงศ์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '130013006', id FROM instructors
 WHERE first_name='อาจารย์' AND last_name='พนมกร ภักดีชัย'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '130013008', id FROM instructors
 WHERE first_name='อัญญารัตน์' AND last_name='พานิชวัฒน์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '130013010', id FROM instructors
 WHERE first_name='ชลธิชา' AND last_name='เจริญสุข'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '130013011', id FROM instructors
 WHERE first_name='ปริญญา' AND last_name='เกษมรัตน์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80203901', id FROM instructors
 WHERE first_name='ธีรพล' AND last_name='โชติธรรม'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80203902', id FROM instructors
 WHERE first_name='รัตติยา' AND last_name='เจนกิจ'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80203903', id FROM instructors
 WHERE first_name='อรอนงค์' AND last_name='โสภณชัย'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80203904', id FROM instructors
 WHERE first_name='กิตติเดช' AND last_name='สุทธิวัฒน์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80203905', id FROM instructors
 WHERE first_name='วรเมธ' AND last_name='อุดมทรัพย์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80203906', id FROM instructors
 WHERE first_name='ปิยะดา' AND last_name='มงคลกิจ'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80203907', id FROM instructors
 WHERE first_name='อาจารย์' AND last_name='ดร. ณัฐวดี จันทรกุล'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80203909', id FROM instructors
 WHERE first_name='อาจารย์' AND last_name='ดร. ปฐมพงษ์ รุ่งอรุณ'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80203910', id FROM instructors
 WHERE first_name='วารุณี' AND last_name='ปิ่นแก้ว'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80203911', id FROM instructors
 WHERE first_name='อัมพิกา' AND last_name='สุทธิวัฒน์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80203912', id FROM instructors
 WHERE first_name='จิรายุ' AND last_name='บุญเพ็ง'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80203918', id FROM instructors
 WHERE first_name='Asst.' AND last_name='Prof. Dr. Kevin Rattanapong'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80203920', id FROM instructors
 WHERE first_name='Assoc.' AND last_name='Prof. Dr. Olivia Thanawan'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '802039023', id FROM instructors
 WHERE first_name='อาจารย์' AND last_name='อุไรวรรณ โชติธรรม'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '50213201', id FROM instructors
 WHERE first_name='มณีรัตน์' AND last_name='บุญญาภิรมย์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '170313002', id FROM instructors
 WHERE first_name='กนกพร' AND last_name='รัตนโสภณ'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80303608', id FROM instructors
 WHERE first_name='อาจารย์' AND last_name='ดร. ปิยวัฒน์ สุทธิสกุล'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80203916', id FROM instructors
 WHERE first_name='กวินทร์' AND last_name='เจนกิจ'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80203916', id FROM instructors
 WHERE first_name='อาจารย์' AND last_name='ดร. พงษ์ศิริ วรรณพงศ์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80203917', id FROM instructors
 WHERE first_name='กวินทร์' AND last_name='มณีโชติ'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80203919', id FROM instructors
 WHERE first_name='อัญมณี' AND last_name='สุทธิกุล'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80203921', id FROM instructors
 WHERE first_name='ชัชวาล' AND last_name='กาญจนรักษ์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80303801', id FROM instructors
 WHERE first_name='อาจารย์' AND last_name='ดร. ปรียาภรณ์ ภักดีวงศ์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80303804', id FROM instructors
 WHERE first_name='อาจารย์' AND last_name='ดร. ชนิกานต์ ศรีสวัสดิ์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80203915', id FROM instructors
 WHERE first_name='กิตติภพ' AND last_name='เจริญกุล'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80203922', id FROM instructors
 WHERE first_name='ธนโชติ' AND last_name='พัฒนเดช'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80203924', id FROM instructors
 WHERE first_name='อาจารย์' AND last_name='วรรณิศา กาญจนรักษ์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '130013012', id FROM instructors
 WHERE first_name='อาจารย์' AND last_name='ดร. กมลชนก ศรีสุนทร'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80303611', id FROM instructors
 WHERE first_name='เบญจวรรณ' AND last_name='อินทรรักษ์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '70153810', id FROM instructors
 WHERE first_name='จิราภัทร' AND last_name='วัฒนะกุล'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '150013126', id FROM instructors
 WHERE first_name='ปิยะวัฒน์' AND last_name='พัฒนวงศ์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '70153711', id FROM instructors
 WHERE first_name='ศิริวัฒน์' AND last_name='เกษมศักดิ์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80203908', id FROM instructors
 WHERE first_name='สิทธิโชค' AND last_name='เจริญสิน'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80303803', id FROM instructors
 WHERE first_name='อาจารย์' AND last_name='สิทธิโชค ศรีสวัสดิ์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80303101', id FROM instructors
 WHERE first_name='คเชนทร์' AND last_name='มณีโชติ'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80303103', id FROM instructors
 WHERE first_name='ชนิกานต์' AND last_name='ภักดีวงศ์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80303104', id FROM instructors
 WHERE first_name='ลลิตา' AND last_name='จิรพงศ์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80303102', id FROM instructors
 WHERE first_name='ธิดาวรรณ' AND last_name='เกษมรัตน์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80303301', id FROM instructors
 WHERE first_name='จตุรภัทร' AND last_name='ปัญญาวงศ์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80303601', id FROM instructors
 WHERE first_name='จตุพร' AND last_name='เกษมกิจ'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80303602', id FROM instructors
 WHERE first_name='อนุวัฒน์' AND last_name='รัตนกาญจน์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80303603', id FROM instructors
 WHERE first_name='ปิยวัฒน์' AND last_name='ศิริมาศ'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80303606', id FROM instructors
 WHERE first_name='อาจารย์' AND last_name='พงษ์ศิริ มณีศิริ'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80303607', id FROM instructors
 WHERE first_name='ธิดาวรรณ' AND last_name='ศรีพิพัฒน์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80303609', id FROM instructors
 WHERE first_name='ปกรณ์' AND last_name='ภูมิพัฒน์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80303610', id FROM instructors
 WHERE first_name='อาจารย์' AND last_name='ดร. กิตติพันธ์ ธนวัฒนะ'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '50113405', id FROM instructors
 WHERE first_name='Assoc.' AND last_name='Prof. Dr. Sophia Kittinan'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80303802', id FROM instructors
 WHERE first_name='อัญญารัตน์' AND last_name='มณีศักดิ์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '10013821', id FROM instructors
 WHERE first_name='พัชรี' AND last_name='มงคลชัย'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '10213702', id FROM instructors
 WHERE first_name='วศิน' AND last_name='เกษมศักดิ์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '20003123', id FROM instructors
 WHERE first_name='สิทธิโชค' AND last_name='เจริญสิน'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '30953115', id FROM instructors
 WHERE first_name='อาจารย์' AND last_name='สิทธิโชค ศรีสวัสดิ์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '150013125', id FROM instructors
 WHERE first_name='คเชนทร์' AND last_name='มณีโชติ'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '150013142', id FROM instructors
 WHERE first_name='ชนิกานต์' AND last_name='ภักดีวงศ์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '150013120', id FROM instructors
 WHERE first_name='ลลิตา' AND last_name='จิรพงศ์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '150013122', id FROM instructors
 WHERE first_name='ธิดาวรรณ' AND last_name='เกษมรัตน์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '140813901', id FROM instructors
 WHERE first_name='จตุรภัทร' AND last_name='ปัญญาวงศ์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '40603002', id FROM instructors
 WHERE first_name='อาจารย์' AND last_name='จารุวัฒน์ พานิชโยธิน'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '40603004', id FROM instructors
 WHERE first_name='ปรียาภรณ์' AND last_name='จารุวัฒนะ'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '10123801', id FROM instructors
 WHERE first_name='อาจารย์' AND last_name='ดร. ปวริศ ทองมาก'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '10123802', id FROM instructors
 WHERE first_name='ภัทรพงศ์' AND last_name='โสภณรัตน์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '10123803', id FROM instructors
 WHERE first_name='ชนิกานต์' AND last_name='เจริญสิน'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '10313528', id FROM instructors
 WHERE first_name='วรวิทย์' AND last_name='ศรีพิพัฒน์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '20003101', id FROM instructors
 WHERE first_name='ศราวุธ' AND last_name='ชูเกียรติ'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '20003102', id FROM instructors
 WHERE first_name='ธิดาวรรณ' AND last_name='ศุภเดช'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '20003103', id FROM instructors
 WHERE first_name='ณัฐพงศ์' AND last_name='วรางค์ไพศาล'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '20003104', id FROM instructors
 WHERE first_name='ณัฐวดี' AND last_name='เจนกิจ'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '20003105', id FROM instructors
 WHERE first_name='วิชญา' AND last_name='อินทรสกุล'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '30113206', id FROM instructors
 WHERE first_name='ฐิติรัตน์' AND last_name='เจริญวงศ์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '40603003', id FROM instructors
 WHERE first_name='ขวัญใจ' AND last_name='อนันต์กุล'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '40603005', id FROM instructors
 WHERE first_name='อัครพล' AND last_name='ธนานนท์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '61100002', id FROM instructors
 WHERE first_name='ธนาพร' AND last_name='วรเศรษฐ์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '70153813', id FROM instructors
 WHERE first_name='กัญญาณัฐ' AND last_name='มณีวงศ์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '150013121', id FROM instructors
 WHERE first_name='กฤติเดช' AND last_name='จิรพัฒน์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '150013124', id FROM instructors
 WHERE first_name='พัชราภรณ์' AND last_name='ศรีประเสริฐ'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '120113701', id FROM instructors
 WHERE first_name='อาจารย์' AND last_name='อนิรุทธิ์ ปัญญานนท์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '120113702', id FROM instructors
 WHERE first_name='วิไลรัตน์' AND last_name='ศิริวัฒน์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '120113703', id FROM instructors
 WHERE first_name='อาภรณ์' AND last_name='เจริญสุข'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '130013007', id FROM instructors
 WHERE first_name='อาจารย์' AND last_name='อรพิน พงษ์ศิริ'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '130013013', id FROM instructors
 WHERE first_name='อาจารย์' AND last_name='ดร. มธุรส มงคลสุข'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '130013019', id FROM instructors
 WHERE first_name='ปิยะกุล' AND last_name='พีรศักดิ์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '120313701', id FROM instructors
 WHERE first_name='นฤมล' AND last_name='วรเศรษฐ์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '120513158', id FROM instructors
 WHERE first_name='อัญชลี' AND last_name='พงศ์สวัสดิ์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80303401', id FROM instructors
 WHERE first_name='วรวิทย์' AND last_name='ปิ่นทอง'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80303501', id FROM instructors
 WHERE first_name='วิภาวดี' AND last_name='พงศ์ประเสริฐ'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80303502', id FROM instructors
 WHERE first_name='นภัสสร' AND last_name='ศิริพรหม'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80303503', id FROM instructors
 WHERE first_name='ธนาพร' AND last_name='โชติธรรม'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80303504', id FROM instructors
 WHERE first_name='วรรณิศา' AND last_name='ธนานนท์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80303505', id FROM instructors
 WHERE first_name='อาจารย์' AND last_name='จตุรภัทร เจนกิจ'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80303507', id FROM instructors
 WHERE first_name='อรทัย' AND last_name='วัฒนบวร'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80303515', id FROM instructors
 WHERE first_name='พิชญา' AND last_name='สิริรัตน์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80303516', id FROM instructors
 WHERE first_name='กวินทร์' AND last_name='ศิริมาศ'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80303517', id FROM instructors
 WHERE first_name='เกียรติศักดิ์' AND last_name='รัตนกาญจน์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80303518', id FROM instructors
 WHERE first_name='คเชนทร์' AND last_name='ทองสิทธิ์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80303519', id FROM instructors
 WHERE first_name='ศราวุธ' AND last_name='อินทรวิชัย'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80303520', id FROM instructors
 WHERE first_name='อาจารย์' AND last_name='จตุพร ธนเดช'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80303521', id FROM instructors
 WHERE first_name='อาจารย์' AND last_name='วินัย ปัญญาวงศ์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80303509', id FROM instructors
 WHERE first_name='เบญจวรรณ' AND last_name='เจริญกุล'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80303510', id FROM instructors
 WHERE first_name='ชนิกานต์' AND last_name='จารุพงษ์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80303513', id FROM instructors
 WHERE first_name='ปุณยวีร์' AND last_name='พงศ์ประเสริฐ'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80303514', id FROM instructors
 WHERE first_name='อาจารย์' AND last_name='ดร. อาภาพร วรรณพงศ์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80303522', id FROM instructors
 WHERE first_name='ศศิธร' AND last_name='พิพัฒน์ธนกุล'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80303523', id FROM instructors
 WHERE first_name='อุไรวรรณ' AND last_name='ปัญญาวงศ์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80303524', id FROM instructors
 WHERE first_name='ธนาพร' AND last_name='ศรีมงคล'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80303525', id FROM instructors
 WHERE first_name='ปริญญา' AND last_name='วัฒนะสถิตย์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '40313017', id FROM instructors
 WHERE first_name='นเรศ' AND last_name='ปัญญาวงศ์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80303526', id FROM instructors
 WHERE first_name='อาจารย์' AND last_name='ธีรเดช วัฒนะกุล'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80303527', id FROM instructors
 WHERE first_name='ปิยะวัฒน์' AND last_name='สุนทรพงศ์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '80303528', id FROM instructors
 WHERE first_name='อัญญารัตน์' AND last_name='ศรีวัฒน์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '60434032', id FROM instructors
 WHERE first_name='รัตนาภรณ์' AND last_name='มณีสุวรรณ'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '150013163', id FROM instructors
 WHERE first_name='อรพิน' AND last_name='จิรพัฒน์'
ON CONFLICT DO NOTHING;
INSERT INTO course_instructors(course_code, instructor_id)
SELECT '150013164', id FROM instructors
 WHERE first_name='วรารัตน์' AND last_name='พีระเดช'
ON CONFLICT DO NOTHING;
COMMIT;