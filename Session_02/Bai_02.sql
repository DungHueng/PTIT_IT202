CREATE DATABASE SS02_DDL_Bai02_table;
USE SS02_DDL_Bai02_table;
CREATE TABLE students(
student_id int primary key,
student_name varchar(50) not null 
);

CREATE TABLE subjects(
subject_id int primary key,
subject_name varchar(20) not null,
credit int not null
);