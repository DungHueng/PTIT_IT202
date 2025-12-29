create database SS03_DML_table;
use SS03_DML_table;

create table student(
student_id int primary key auto_increment,
full_name varchar(50) not null,
date_of_birth date not null,
email varchar(40) unique
);