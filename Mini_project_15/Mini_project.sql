/*
 * DATABASE SETUP - SESSION 15 EXAM
 * Database: StudentManagement
 */

DROP DATABASE IF EXISTS StudentManagement;
CREATE DATABASE StudentManagement;
USE StudentManagement;

-- =============================================
-- 1. TABLE STRUCTURE
-- =============================================

-- Table: Students
CREATE TABLE Students (
    StudentID CHAR(5) PRIMARY KEY,
    FullName VARCHAR(50) NOT NULL,
    TotalDebt DECIMAL(10,2) DEFAULT 0
);

-- Table: Subjects
CREATE TABLE Subjects (
    SubjectID CHAR(5) PRIMARY KEY,
    SubjectName VARCHAR(50) NOT NULL,
    Credits INT CHECK (Credits > 0)
);

-- Table: Grades
CREATE TABLE Grades (
    StudentID CHAR(5),
    SubjectID CHAR(5),
    Score DECIMAL(4,2) CHECK (Score BETWEEN 0 AND 10),
    PRIMARY KEY (StudentID, SubjectID),
    CONSTRAINT FK_Grades_Students FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    CONSTRAINT FK_Grades_Subjects FOREIGN KEY (SubjectID) REFERENCES Subjects(SubjectID)
);

-- Table: GradeLog
CREATE TABLE GradeLog (
    LogID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID CHAR(5),
    OldScore DECIMAL(4,2),
    NewScore DECIMAL(4,2),
    ChangeDate DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- =============================================
-- 2. SEED DATA
-- =============================================

-- Insert Students
INSERT INTO Students (StudentID, FullName, TotalDebt) VALUES 
('SV01', 'Ho Khanh Linh', 5000000),
('SV03', 'Tran Thi Khanh Huyen', 0);

-- Insert Subjects
INSERT INTO Subjects (SubjectID, SubjectName, Credits) VALUES 
('SB01', 'Co so du lieu', 3),
('SB02', 'Lap trinh Java', 4),
('SB03', 'Lap trinh C', 3);

-- Insert Grades
INSERT INTO Grades (StudentID, SubjectID, Score) VALUES 
('SV01', 'SB01', 8.5), -- Passed
('SV03', 'SB02', 3.0); -- Failed

#PHẦN A – CƠ BẢN (4 điểm)
#Câu 1 (Trigger - 2đ): Nhà trường yêu cầu điểm số (Score) nhập vào hệ thống phải luôn hợp lệ (từ 0 đến 10). Hãy viết một Trigger có tên tg_CheckScore chạy trước khi thêm (BEFORE INSERT) dữ liệu vào bảng Grades.
DELIMITER //
create trigger tg_CheckScore
before insert on grades
for each row
-- Nếu người dùng nhập Score < 0 thì tự động gán về 0.
begin
	if new.score < 0 then
    set new.score = 0;
    -- Nếu người dùng nhập Score > 10 thì tự động gán về 10.
    elseif new.score > 10 then
    set new.score = 10;
    end if;
end //

#Câu 2 (Transaction - 2đ): Viết một đoạn script sử dụng Transaction để thêm một sinh viên mới. Yêu cầu đảm bảo tính trọn vẹn "All or Nothing" của dữ liệu:
-- Bắt đầu Transaction.
start transaction;
-- Thêm sinh viên mới vào bảng Students: StudentID = 'SV02', FullName = 'Ha Bich Ngoc'.
insert into students (studentID, FullName) values
('SV02', 'Ha Bich Ngoc');
-- Cập nhật nợ học phí (TotalDebt) cho sinh viên này là 5,000,000.
update students set TotalDebt = TotalDebt + 5000000
where StudentID = 'SV02'
-- Xác nhận (COMMIT) Transaction.
commit;

#PHẦN B – KHÁ (3 điểm)
#Câu 3 (Trigger - 1.5đ): Để chống tiêu cực trong thi cử, mọi hành động sửa đổi điểm số cần được ghi lại. Hãy viết Trigger tên tg_LogGradeUpdate chạy sau khi cập nhật (AFTER UPDATE) trên bảng Grades.
DELIMITER //
create trigger tg_LogGradeUpdate
after insert on grades_log
for each row
begin
insert into (StudentID, OldScore, NewScore, ChangeDate)
values
end //