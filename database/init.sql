CREATE TABLE student (
    student_id VARCHAR(20) PRIMARY KEY,
    student_name VARCHAR(20),
    department VARCHAR(30),
    grade INT,
    credit INT DEFAULT 0
);

INSERT INTO student (student_id, student_name, department, grade) VALUES
('D2582136', 'Chewing'      , 'Chinese Literature'      , 1),
('D0931153', 'HY, Lin'      , 'Biology'                 , 1),
('D3899347', 'Candy, Li'    , 'Biology'                 , 1),
('D8923416', 'Pocky'        , 'Computer Science'        , 2),
('D5009548', 'Sweet Potato' , 'Computer Science'        , 2),
('D5452012', 'Chung, Hung'  , 'Computer Science'        , 2),
('D1805916', 'Sean'         , 'Computer Science'        , 2),
('D3211302', 'Guei'         , 'Computer Science'        , 4),
('D2573744', 'CY, Tsai'     , 'Computer Science'        , 2),
('D1904172', 'Katie'        , 'Electrical Engineering'  , 2),
('D9949956', 'Wanderer'     , 'Electrical Engineering'  , 2),
('D2196134', 'Moderato'     , 'Physics'                 , 2),
('D7350136', 'Paimberley'   , 'Chemistry'               , 2),
('D6361597', 'Astrid'       , 'Law'                     , 2),
('D1136116', 'Ivy'          , 'Economics'               , 4),
('D4532771', 'Douherbo'     , 'Agronomy'                , 1);



CREATE TABLE course (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(20),
    department VARCHAR(30),
    grade INT,
    credits INT,
    capacity INT,
    requirement_course BOOL
);

INSERT INTO course (course_id, course_name, department, grade, credits, capacity, requirement_course) VALUES
(1, '中國古典文學導論', 'Chinese Literature', 1, 3, 5, 1),
(2, '中國現代文學導論', 'Chinese Literature', 1, 3, 5, 1),
(3, '現代散文選讀', 'Chinese Literature', 3, 3, 5, 0),
(4, '唐詩選讀', 'Chinese Literature', 1, 2, 5, 0),
(5, '宋詞選讀', 'Chinese Literature', 2, 2, 5, 0),
(6, '元曲選讀', 'Chinese Literature', 3, 2, 5, 0),
(7, '明清小說選讀', 'Chinese Literature', 1, 3, 5, 0),
(8, '近現代散文選讀', 'Chinese Literature', 2, 3, 5, 0),
(9, '中國文學史', 'Chinese Literature', 1, 3, 5, 1);

INSERT INTO course (course_id, course_name, department, grade, credits, capacity, requirement_course) VALUES
(101, '生物基礎', 'Biology', 1, 3, 5, 1),
(102, '細胞生物學', 'Biology', 2, 3, 5, 0),
(103, '遺傳學', 'Biology', 3, 3, 5, 0),
(104, '演化生物學', 'Biology', 1, 3, 5, 0),
(105, '生態學', 'Biology', 2, 3, 5, 0),
(106, '生物化學', 'Biology', 3, 3, 5, 0),
(107, '微生物學', 'Biology', 1, 3, 5, 0),
(108, '植物學', 'Biology', 1, 3, 5, 1),
(109, '動物學', 'Biology', 1, 3, 5, 1);

INSERT INTO course (course_id, course_name, department, grade, credits, capacity, requirement_course) VALUES
(201, '程式設計基礎', 'Computer Science', 1, 3, 5, 1),
(202, '資料結構與演算法', 'Computer Science', 2, 3, 5, 1),
(203, '作業系統', 'Computer Science', 3, 3, 5, 0),
(204, '計算機組織與結構', 'Computer Science', 3, 3, 5, 1),
(205, '資料庫系統', 'Computer Science', 2, 3, 5, 1),
(206, '編譯原理', 'Computer Science', 3, 3, 5, 0),
(207, '人工智慧', 'Computer Science', 1, 3, 5, 0),
(208, '機器學習', 'Computer Science', 2, 3, 5, 0),
(209, '網路程式設計', 'Computer Science', 2, 3, 5, 0),
(210, '系統程式', 'Computer Science', 2, 3, 5, 1);

INSERT INTO course (course_id, course_name, department, grade, credits, capacity, requirement_course) VALUES
(301, '電路學', 'Electrical Engineering', 1, 3, 5, 0),
(302, '訊號與系統', 'Electrical Engineering', 2, 3, 5, 0),
(303, '電力系統', 'Electrical Engineering', 3, 3, 5, 0),
(304, '控制系統', 'Electrical Engineering', 1, 3, 5, 0),
(305, '電子電路', 'Electrical Engineering', 2, 3, 5, 0),
(306, '電磁學', 'Electrical Engineering', 3, 3, 5, 0),
(307, '數位訊號處理', 'Electrical Engineering', 1, 3, 5, 0),
(308, '通訊原理', 'Electrical Engineering', 2, 3, 5, 0),
(309, '微機電系統', 'Electrical Engineering', 3, 3, 5, 0),
(310, '計算機概論', 'Electrical Engineering', 1, 3, 5, 1),
(311, '微機電系統', 'Electrical Engineering', 3, 3, 5, 0);

INSERT INTO course (course_id, course_name, department, grade, credits, capacity, requirement_course) VALUES
(401, '農業生態學', 'Agronomy', 1, 3, 5, 1),
(402, '農產品加工學', 'Agronomy', 2, 3, 5, 0),
(403, '作物栽培學', 'Agronomy', 3, 3, 5, 0),
(404, '土壤學', 'Agronomy', 1, 3, 5, 1),
(405, '植物保護學', 'Agronomy', 2, 3, 5, 0),
(406, '農業經濟學', 'Agronomy', 3, 3, 5, 0),
(407, '園藝學', 'Agronomy', 1, 3, 5, 1),
(408, '水稻學', 'Agronomy', 2, 3, 5, 0),
(409, '果樹學', 'Agronomy', 3, 3, 5, 0),
(410, '畜牧學', 'Agronomy', 3, 3, 5, 0);

INSERT INTO course (course_id, course_name, department, grade, credits, capacity, requirement_course) VALUES
(501, '經典力學', 'Physics', 1, 3, 5, 0),
(502, '電磁學', 'Physics', 2, 3, 5, 0),
(503, '量子力學', 'Physics', 3, 3, 5, 0),
(504, '熱力學', 'Physics', 1, 3, 5, 0),
(505, '統計力學', 'Physics', 2, 3, 5, 0),
(506, '固體物理學', 'Physics', 3, 3, 5, 0),
(507, '天文學', 'Physics', 3, 3, 5, 0),
(508, '相對論', 'Physics', 2, 3, 5, 0),
(509, '粒子物理學', 'Physics', 3, 3, 5, 0);

INSERT INTO course (course_id, course_name, department, grade, credits, capacity, requirement_course) VALUES
(601, '基礎化學', 'Chemistry', 1, 3, 5, 0),
(602, '有機化學', 'Chemistry', 2, 3, 5, 0),
(603, '物理化學', 'Chemistry', 3, 3, 5, 0),
(604, '分析化學', 'Chemistry', 1, 3, 5, 0),
(605, '無機化學', 'Chemistry', 2, 3, 5, 0),
(606, '生物化學', 'Chemistry', 3, 3, 5, 0),
(607, '材料化學', 'Chemistry', 1, 3, 5, 0),
(608, '光化學', 'Chemistry', 2, 3, 5, 0),
(609, '電化學', 'Chemistry', 3, 3, 5, 0);

INSERT INTO course (course_id, course_name, department, grade, credits, capacity, requirement_course) VALUES
(701, '微積分', 'Mathematics', 1, 3, 5, 0),
(702, '線性代數', 'Mathematics', 2, 3, 5, 0),
(703, '微分方程', 'Mathematics', 3, 3, 5, 0),
(704, '數理邏輯', 'Mathematics', 1, 3, 5, 0),
(705, '離散數學', 'Mathematics', 2, 3, 5, 0),
(706, '概率論', 'Mathematics', 3, 3, 5, 0),
(707, '統計學', 'Mathematics', 1, 3, 5, 0),
(708, '數值分析', 'Mathematics', 2, 3, 5, 0),
(709, '幾何學', 'Mathematics', 3, 3, 5, 0);

INSERT INTO course (course_id, course_name, department, grade, credits, capacity, requirement_course) VALUES
(801, '憲法學', 'Law', 1, 3, 5, 1),
(802, '民法學', 'Law', 2, 3, 5, 1),
(803, '刑法學', 'Law', 3, 3, 5, 1),
(804, '商法學', 'Law', 1, 3, 5, 0),
(805, '國際法', 'Law', 2, 3, 5, 0),
(806, '行政法', 'Law', 3, 3, 5, 0),
(807, '訴訟法', 'Law', 1, 3, 5, 0),
(808, '環境法', 'Law', 2, 3, 5, 0),
(809, '勞動法', 'Law', 3, 3, 5, 0);

INSERT INTO course (course_id, course_name, department, grade, credits, capacity, requirement_course) VALUES
(901, '經濟學原理', 'Economics', 1, 3, 5, 0),
(902, '微觀經濟學', 'Economics', 2, 3, 5, 0),
(903, '宏觀經濟學', 'Economics', 3, 3, 5, 0),
(904, '國際經濟學', 'Economics', 1, 3, 5, 0),
(905, '財政學', 'Economics', 2, 3, 5, 0),
(906, '金融學', 'Economics', 3, 3, 5, 0),
(907, '發展經濟學', 'Economics', 1, 3, 5, 0),
(908, '計量經濟學', 'Economics', 2, 3, 5, 0),
(909, '環境經濟學', 'Economics', 3, 3, 5, 0);

INSERT INTO course (course_id, course_name, department, grade, credits, capacity, requirement_course) VALUES
(1001, '高效休息法', 'General Eudcation', 0, 8, 10, 0),
(1002, '閱讀越快樂', 'General Eudcation', 0, 4, 10, 0),
(1003, '誇誇學導論', 'General Eudcation', 0, 5, 10, 0);


CREATE TABLE course_schedule (
    course_id INT,
    weekday INT,
    period INT,
    FOREIGN KEY (course_id) REFERENCES course(course_id)
);



CREATE TABLE course_enroll (
    course_id INT,
    student_id VARCHAR(20),
    FOREIGN KEY (course_id) REFERENCES course(course_id),
    FOREIGN KEY (student_id) REFERENCES student(student_id)
);

-- 中國古典文學導論
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(1, 1, 1),
(1, 3, 2),
(1, 5, 3);

-- 中國現代文學導論
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(2, 2, 1),
(2, 4, 2),
(2, 6, 3);

-- 現代散文選讀
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(3, 1, 4),
(3, 3, 5),
(3, 5, 6);

-- 唐詩選讀
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(4, 2, 4),
(4, 4, 5);


-- 宋詞選讀
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(5, 1, 7),
(5, 3, 1);


-- 元曲選讀
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(6, 2, 7),
(6, 4, 1);

-- 明清小說選讀
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(7, 1, 3),
(7, 3, 4),
(7, 5, 5);

-- 近現代散文選讀
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(8, 2, 3),
(8, 4, 4),
(8, 6, 5);

-- 中國文學史
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(9, 1, 6),
(9, 3, 7),
(9, 5, 1);

-- 生物基礎
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(101, 1, 1),
(101, 3, 2),
(101, 5, 3);

-- 細胞生物學
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(102, 2, 1),
(102, 4, 2),
(102, 6, 3);

-- 遺傳學
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(103, 1, 4),
(103, 3, 5),
(103, 5, 6);

-- 演化生物學
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(104, 2, 4),
(104, 4, 5),
(104, 6, 6);

-- 生態學
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(105, 1, 7),
(105, 3, 1),
(105, 5, 2);

-- 生物化學
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(106, 2, 7),
(106, 4, 1),
(106, 6, 2);

-- 微生物學
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(107, 1, 3),
(107, 3, 4),
(107, 5, 5);

-- 植物學
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(108, 2, 3),
(108, 4, 4),
(108, 6, 5);

-- 動物學
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(109, 1, 6),
(109, 3, 7),
(109, 5, 1);

-- 程式設計基礎
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(201, 1, 1),
(201, 3, 2),
(201, 5, 3);

-- 資料結構與演算法
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(202, 2, 1),
(202, 4, 2),
(202, 6, 3);

-- 作業系統
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(203, 1, 4),
(203, 3, 5),
(203, 5, 6);

-- 計算機組織與結構
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(204, 2, 4),
(204, 4, 5),
(204, 6, 6);

-- 資料庫系統
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(205, 1, 7),
(205, 3, 1),
(205, 5, 2);

-- 編譯原理
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(206, 2, 7),
(206, 4, 1),
(206, 6, 2);

-- 人工智慧
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(207, 1, 3),
(207, 3, 4),
(207, 5, 5);

-- 機器學習
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(208, 2, 3),
(208, 4, 4),
(208, 6, 5);

-- 網路程式設計
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(209, 1, 6),
(209, 3, 7),
(209, 5, 1);

-- 電路學
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(301, 1, 1),
(301, 3, 2),
(301, 5, 3);

-- 訊號與系統
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(302, 2, 1),
(302, 4, 2),
(302, 6, 3);

-- 電力系統
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(303, 1, 4),
(303, 3, 5),
(303, 5, 6);

-- 控制系統
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(304, 2, 4),
(304, 4, 5),
(304, 6, 6);

-- 電子電路
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(305, 1, 7),
(305, 3, 1),
(305, 5, 2);

-- 電磁學
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(306, 2, 7),
(306, 4, 1),
(306, 6, 2);

-- 數位訊號處理
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(307, 1, 3),
(307, 3, 4),
(307, 5, 5);

-- 通訊原理
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(308, 2, 3),
(308, 4, 4),
(308, 6, 5);

-- 微機電系統
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(309, 1, 6),
(309, 3, 7),
(309, 5, 1);

-- 農業生態學
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(401, 1, 1),
(401, 3, 2),
(401, 5, 3);

-- 農產品加工學
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(402, 2, 1),
(402, 4, 2),
(402, 6, 3);

-- 作物栽培學
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(403, 1, 4),
(403, 3, 5),
(403, 5, 6);

-- 土壤學
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(404, 2, 4),
(404, 4, 5),
(404, 6, 6);

-- 植物保護學
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(405, 1, 7),
(405, 3, 1),
(405, 5, 2);

-- 農業經濟學
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(406, 2, 7),
(406, 4, 1),
(406, 6, 2);

-- 園藝學
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(407, 1, 3),
(407, 3, 4),
(407, 5, 5);

-- 水稻學
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(408, 2, 3),
(408, 4, 4),
(408, 6, 5);

-- 果樹學
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(409, 1, 6),
(409, 3, 7),
(409, 5, 1);

-- 畜牧學
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(410, 2, 6),
(410, 4, 7),
(410, 6, 1);

-- 經典力學
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(501, 1, 1),
(501, 3, 2),
(501, 5, 3);

-- 電磁學
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(502, 2, 1),
(502, 4, 2),
(502, 6, 3);

-- 量子力學
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(503, 1, 4),
(503, 3, 5),
(503, 5, 6);

-- 熱力學
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(504, 2, 4),
(504, 4, 5),
(504, 6, 6);

-- 統計力學
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(505, 1, 7),
(505, 3, 1),
(505, 5, 2);

-- 固體物理學
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(506, 2, 7),
(506, 4, 1),
(506, 6, 2);

-- 天文學
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(507, 1, 3),
(507, 3, 4),
(507, 5, 5);

-- 相對論
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(508, 2, 3),
(508, 4, 4),
(508, 6, 5);

-- 粒子物理學
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(509, 1, 6),
(509, 3, 7),
(509, 5, 1);

-- 基礎化學
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(601, 1, 1),
(601, 3, 2),
(601, 5, 3);

-- 有機化學
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(602, 2, 1),
(602, 4, 2),
(602, 6, 3);

-- 物理化學
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(603, 1, 4),
(603, 3, 5),
(603, 5, 6);

-- 分析化學
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(604, 2, 4),
(604, 4, 5),
(604, 6, 6);

-- 無機化學
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(605, 1, 7),
(605, 3, 1),
(605, 5, 2);

-- 生物化學
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(606, 2, 7),
(606, 4, 1),
(606, 6, 2);

-- 材料化學
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(607, 1, 3),
(607, 3, 4),
(607, 5, 5);

-- 光化學
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(608, 2, 3),
(608, 4, 4),
(608, 6, 5);

-- 電化學
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(69, 1, 6),
(69, 3, 7),
(69, 5, 1);

-- 微積分
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(701, 1, 1),
(701, 3, 2),
(701, 5, 3);

-- 線性代數
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(702, 2, 1),
(702, 4, 2),
(702, 6, 3);

-- 微分方程
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(703, 1, 4),
(703, 3, 5),
(703, 5, 6);

-- 數理邏輯
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(704, 2, 4),
(704, 4, 5),
(704, 6, 6);

-- 離散數學
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(705, 1, 7),
(705, 3, 1),
(705, 5, 2);

-- 概率論
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(706, 2, 7),
(706, 4, 1),
(706, 6, 2);

-- 統計學
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(707, 1, 3),
(707, 3, 4),
(707, 5, 5);

-- 數值分析
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(708, 2, 3),
(708, 4, 4),
(708, 6, 5);

-- 幾何學
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(709, 1, 6),
(709, 3, 7),
(709, 5, 1);

-- 憲法學
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(801, 1, 1),
(801, 3, 2),
(801, 5, 3);

-- 民法學
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(802, 2, 1),
(802, 4, 2),
(802, 6, 3);

-- 刑法學
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(803, 1, 4),
(803, 3, 5),
(803, 5, 6);

-- 商法學
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(804, 2, 4),
(804, 4, 5),
(804, 6, 6);

-- 國際法
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(805, 1, 7),
(805, 3, 1),
(805, 5, 2);

-- 行政法
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(806, 2, 7),
(806, 4, 1),
(806, 6, 2);

-- 訴訟法
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(807, 1, 3),
(807, 3, 4),
(807, 5, 5);

-- 環境法
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(808, 2, 3),
(808, 4, 4),
(808, 6, 5);

-- 勞動法
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(809, 1, 6),
(809, 3, 7),
(809, 5, 1);

-- 經濟學原理
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(901, 1, 1),
(901, 3, 2),
(901, 5, 3);

-- 微觀經濟學
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(902, 2, 1),
(902, 4, 2),
(902, 6, 3);

-- 宏觀經濟學
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(903, 1, 4),
(903, 3, 5),
(903, 5, 6);

-- 國際經濟學
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(904, 2, 4),
(904, 4, 5),
(904, 6, 6);

-- 財政學
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(905, 1, 7),
(905, 3, 1),
(905, 5, 2);

-- 金融學
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(906, 2, 7),
(906, 4, 1),
(906, 6, 2);

-- 發展經濟學
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(907, 1, 3),
(907, 3, 4),
(907, 5, 5);

-- 計量經濟學
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(908, 2, 3),
(908, 4, 4),
(908, 6, 5);

-- 環境經濟學
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(909, 1, 6),
(909, 3, 7),
(909, 5, 1);

-- 高效休息法
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(1001, 3, 1),
(1001, 3, 2),
(1001, 3, 3),
(1001, 3, 4),
(1001, 3, 5);

-- 閱讀越快樂
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(1002, 3, 6),
(1002, 3, 7),
(1002, 3, 8),
(1002, 3, 9);

-- 誇誇學導論
INSERT INTO course_schedule (course_id, weekday, period) VALUES
(1003, 0, 2),
(1003, 0, 3),
(1003, 0, 4),
(1003, 1, 3),
(1003, 1, 4);

INSERT INTO course_enroll (student_id, course_id)
SELECT s.student_id, c.course_id
FROM student s
JOIN course c ON s.grade = c.grade AND s.department = c.department
WHERE c.requirement_course = 1;

UPDATE student 
INNER JOIN (
    SELECT student.student_id, SUM(course.credits) AS total_credits
    FROM student
    INNER JOIN course_enroll ON student.student_id = course_enroll.student_id
    INNER JOIN course ON course_enroll.course_id = course.course_id
    GROUP BY student.student_id
) AS new_credits ON student.student_id = new_credits.student_id
SET student.credit = new_credits.total_credits;

