use SS03_DML_table;
create table subjects(
subject_id int primary key,
subject_name varchar(50) not null,
credit int not null,
check(credit > 0)
);
insert into subjects(subject_id,subject_name,credit)
values
(1, 'Lap trinh C', 4),
(2, 'Lap trinh front-end', 2),
(3, 'Cau truc du lieu va giai thuat', 3);

update subjects
set credit = 4
where subject_id = 2;

update subjects
set subject_name = 'Lap trinh back-end'
where subject_id = 2;

create table student(
student_id int primary key,
full_name varchar(50) not null,
date_of_birth date not null,
email varchar(40) unique
);
insert into student(student_id,full_name,date_of_birth,email)
values
(01, 'Nguyen Van A', '2006-01-01', 'nguyenvana@gmail.com'),
(02, 'Nguyen Van B', '2006-02-01', 'nguyenvanb@gmail.com'),
(03, 'Nguyen Van C', '2006-02-02', 'nguyenvanc@gmail.com'),
(04, 'Nguyen Van D', '2007-03-02', 'nguyenvand@gmail.com'),
(05, 'Nguyen Van E', '2008-04-02', 'nguyenvane@gmail.com');

update student
set email='tranthic@gmail.com'
where student_id = 3;

update student
set date_of_birth='2000-12-12'
where student_id = 02;

delete from student
where student_id = 05;

INSERT INTO enrollment (student_id, subject_id, enroll_date)
VALUES
(1, 1, '2025-12-20'),
(1, 3, '2025-12-21'),
(2, 2, '2025-12-22');

select * from enrollment;

select * from enrollment
where student_id = 01;