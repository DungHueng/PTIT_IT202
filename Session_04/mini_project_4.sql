DROP DATABASE IF EXISTS online_learning;
CREATE DATABASE online_learning;
USE online_learning;

CREATE TABLE Teacher (
    teacher_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name  VARCHAR(100) NOT NULL,
    email      VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Student (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name  VARCHAR(100) NOT NULL,
    dob        DATE NOT NULL,
    email      VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Course (
    course_id     INT AUTO_INCREMENT PRIMARY KEY,
    course_name   VARCHAR(150) NOT NULL,
    short_desc    VARCHAR(255),
    session_count INT NOT NULL,
    teacher_id    INT NOT NULL,
    CHECK (session_count > 0),
    FOREIGN KEY (teacher_id) REFERENCES Teacher(teacher_id)
);

CREATE TABLE Enrollment (
    student_id  INT NOT NULL,
    course_id   INT NOT NULL,
    enroll_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (course_id)  REFERENCES Course(course_id)
);

CREATE TABLE Score (
    student_id    INT NOT NULL,
    course_id     INT NOT NULL,
    midterm_score DECIMAL(4,2) NOT NULL,
    final_score   DECIMAL(4,2) NOT NULL,
    PRIMARY KEY (student_id, course_id),
    CHECK (midterm_score >= 0 AND midterm_score <= 10),
    CHECK (final_score   >= 0 AND final_score   <= 10),
    FOREIGN KEY (student_id, course_id) REFERENCES Enrollment(student_id, course_id)
);

INSERT INTO Teacher (full_name, email) VALUES
('Nguyễn Minh Khang', 'khang.nm@uni.edu.vn'),
('Trần Thu Hà',       'ha.tt@uni.edu.vn'),
('Lê Quốc Anh',       'anh.lq@uni.edu.vn'),
('Phạm Ngọc Lan',     'lan.pn@uni.edu.vn'),
('Vũ Đức Long',       'long.vd@uni.edu.vn');

INSERT INTO Student (full_name, dob, email) VALUES
('Nguyễn Văn An',  '2004-03-12', 'an.nv@student.edu.vn'),
('Trần Thị Bình',  '2004-07-25', 'binh.tt@student.edu.vn'),
('Lê Hoàng Cường', '2003-11-02', 'cuong.lh@student.edu.vn'),
('Phạm Gia Duy',   '2004-01-19', 'duy.pg@student.edu.vn'),
('Đặng Thùy Linh', '2004-09-08', 'linh.dt@student.edu.vn');

INSERT INTO Course (course_name, short_desc, session_count, teacher_id) VALUES
('SQL Cơ bản',         'Học DDL/DML và SELECT', 12, 1),
('Lập trình Web',      'HTML/CSS/JS cơ bản',    18, 2),
('Cấu trúc dữ liệu',   'Stack/Queue/Tree...',  20, 3),
('Java OOP',           'Hướng đối tượng',       16, 4),
('Phân tích hệ thống', 'Use Case, ERD, UML',    14, 5);

INSERT INTO Enrollment (student_id, course_id, enroll_date) VALUES
(1, 1, '2025-12-01'),
(1, 2, '2025-12-03'),
(2, 1, '2025-12-02'),
(2, 3, '2025-12-05'),
(3, 2, '2025-12-04'),
(3, 4, '2025-12-06'),
(4, 5, '2025-12-07'),
(5, 1, '2025-12-08'),
(5, 5, '2025-12-09');

INSERT INTO Score (student_id, course_id, midterm_score, final_score) VALUES
(1, 1, 7.50, 8.00),
(1, 2, 8.00, 8.50),
(2, 1, 6.50, 7.00),
(2, 3, 7.00, 7.50),
(3, 2, 8.50, 9.00),
(3, 4, 7.50, 8.00),
(4, 5, 6.00, 6.50),
(5, 1, 9.00, 9.50),
(5, 5, 7.00, 7.50);

UPDATE Student
SET email = 'an.nguyen01@student.edu.vn'
WHERE student_id = 1;

UPDATE Course
SET short_desc = 'Tổng quan Use Case, ERD, UML và quy trình phân tích'
WHERE course_id = 5;

UPDATE Score
SET final_score = 8.25
WHERE student_id = 2 AND course_id = 3;

DELETE FROM Score
WHERE student_id = 4 AND course_id = 5;

DELETE FROM Enrollment
WHERE student_id = 4 AND course_id = 5;

SELECT * FROM Student;
SELECT * FROM Teacher;
SELECT * FROM Course;
SELECT * FROM Enrollment;
SELECT * FROM Score;
