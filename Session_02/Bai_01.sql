-- Bai_01
USE SS02_DDL_table;
CREATE TABLE CLASSES(
class_id int primary key auto_increment,
class_name varchar(10) not null unique,
classroom char(10) not null 
);

CREATE TABLE STUDENTS(
student_id int primary key,
student_name varchar(50) not null,
date_birth date not null,
class_id int,
foreign key(class_id) references CLASSES(class_id)
);