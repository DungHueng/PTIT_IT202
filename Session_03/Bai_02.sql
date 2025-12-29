use SS03_DML_table;
insert into
student(student_id, full_name, date_of_birth, email)
values
(04, 'Nguyen Van D', '2007-03-02', 'nguyenvand@gmail.com'),
(05, 'Nguyen Van E', '2008-04-02', 'nguyenvane@gmail.com');

update student
set email = 'tranthic@gmail.com'
where student_id = 03;

update student
set date_of_birth = '2007-12-12'
where student_id = 02;

delete from student
where student_id = 05;

select * from student