CREATE DATABASE SS02_DDL_Bai04_table;
USE SS02_DDL_Bai04_table;
CREATE TABLE subjects (
    subject_id int primary key,
    subject_name varchar(20) not null
);

CREATE TABLE teacher (
    teacher_id int primary key,
    teacher_name varchar(50) not null,
    email varchar(50) not null unique
);

CREATE TABLE teacher_subjects (
    teacher_id int not null,
    subject_id int not null,
    primary key (teacher_id, subject_id),
    foreign key (teacher_id) references teacher(teacher_id),
    foreign key (subject_id) references subjects(subject_id)
);