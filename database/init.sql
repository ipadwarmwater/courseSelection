CREATE TABLE student (
    student_id VARCHAR(20) PRIMARY KEY,
    student_name VARCHAR(20),
    department VARCHAR(30),
    grade INT,
    credit INT DEFAULT 0
);

INSERT INTO student (student_id, student_name, department, grade) VALUES
('D1805916', 'Alice', 'Computer Science', 2),
('D1904172', 'Katie', 'Electrical Engineering', 2),
('D2170255', 'Charlie', 'Mechanical Engineering', 4),
('D2196134', 'Moderato', 'Physics', 2),
('D7350136', 'Emma', 'Chemistry', 3),
('D0931153', 'Frank', 'Biology', 1),
('D3211302', 'Grace', 'Mathematics', 2),
('D6361597', 'Henry', 'History', 3),
('D1136116', 'Ivy', 'Economics', 4),
('D2582136', 'Jack', 'English Literature', 1),
('D4532771', 'Douherbo', 'Agronomy', 1);

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
(1, 'Introduction to Computer Science', 'Computer Science', 1, 3, 50, 0),
(2, 'Electric Circuits', 'Electrical Engineering', 2, 4, 40, 1),
(3, 'Thermodynamics', 'Mechanical Engineering', 3, 3, 45, 1),
(4, 'Modern Physics', 'Physics', 2, 4, 40, 1),
(5, 'Organic Chemistry', 'Chemistry', 2, 4, 35, 1),
(6, 'Cell Biology', 'Biology', 1, 3, 55, 0),
(7, 'Calculus I', 'Mathematics', 1, 3, 60, 0),
(8, 'World History', 'History', 3, 3, 50, 0),
(9, 'Microeconomics', 'Economics', 2, 3, 45, 0),
(10, 'Introduction to Literature', 'English Literature', 1, 3, 50, 0);

CREATE TABLE course_schedule (
    course_id INT,
    weekday INT,
    period INT
);

INSERT INTO course_schedule (course_id, weekday, period) VALUES
(1, 1, 1),
(1, 2, 3),
(1, 3, 5),
(2, 1, 2),
(2, 1, 1),
(2, 4, 5),
(2, 4, 6),
(3, 1, 3),
(3, 3, 5),
(3, 5, 7),
(4, 2, 1),
(4, 3, 3),
(4, 4, 5),
(5, 2, 2),
(5, 4, 4),
(5, 5, 6),
(6, 1, 1),
(6, 2, 3),
(6, 4, 5),
(7, 1, 2),
(7, 3, 4),
(7, 5, 6),
(8, 1, 1),
(8, 2, 3),
(8, 4, 5),
(9, 1, 2),
(9, 3, 4),
(9, 5, 6),
(10, 1, 1),
(10, 2, 3),
(10, 4, 5);

CREATE TABLE course_enroll (
    course_id INT,
    student_id VARCHAR(20),
    FOREIGN KEY (course_id) REFERENCES course(course_id),
    FOREIGN KEY (student_id) REFERENCES student(student_id)
);


INSERT INTO course_enroll (student_id, course_id)
SELECT s.student_id, c.course_id
FROM student s
JOIN course c ON s.grade = c.grade AND s.department = c.department
WHERE c.requirement_course = 1;

UPDATE student set credit = credit+course.credits WHERE SELECT student inner join course_enroll on student.student_id = course_enroll.student_id;