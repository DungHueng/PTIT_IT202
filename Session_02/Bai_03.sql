CREATE DATABASE SS02_DDL_Bai03_table;
USE SS02_DDL_Bai03_table;
CREATE TABLE students(
student_id int primary key,
student_name varchar(50) not null 
);

CREATE TABLE subjects(
subject_id int primary key,
subject_name varchar(20) not null,
credit int not null
);

CREATE TABLE subject_students(
student_id int not null,
subject_id int not null,
register_date date not null,

primary key (student_id, subject_id),
foreign key(student_id) references students(student_id),
foreign key(subject_id) references subjects(subject_id)
);