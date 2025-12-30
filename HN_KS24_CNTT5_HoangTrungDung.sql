create database project;
use project;

create table reader(
reader_id int primary key auto_increment,
reader_name varchar(100) not null,
phone varchar(15) unique,
register_date date default(current_date())
);

create table book(
book_id int primary key,
book_title varchar(150) not null,
author varchar(100),
publish_year int check(publish_year >= 1900)
);

create table borrow(
reader_id int,
book_id int,
borrow_date date default(current_date()),
return_date date,

primary key (reader_id, book_id),

foreign key (reader_id) references reader(reader_id),
foreign key (book_id) references book(book_id)
);

alter table reader
add column email varchar(100) unique;

alter table book
modify author varchar(150);

alter table borrow
add check (return_date >= borrow_date);

insert into reader(reader_name, phone, email, register_date)
values
('Nguyen Van An', '0901234567', 'an.nguyen@gmail.com', '2024-09-01'),
('Trần Thị Bình', '0912345678', 'binh.tran@gmail.com', '2024-09-05'),
('Lê Minh Châu', '0923456789', 'chau.le@gmail.com', '2024-09-10');

insert into book(book_id, book_title, author, publish_year)
values
(101, 'Lap trinh C can ban', 'Nguyen Van A', 2018),
(102, 'Co so du lieu', 'Tran Thi B', 2020),
(103, 'Lap trinh Java', 'Le Minh C', 2019),
(104, 'He quan tri MySQL', 'Pham Van D', 2021);

insert into borrow(reader_id, book_id, borrow_date, return_date)
values
(101, '2024-09-15'),
(102, '2024-09-15', '2024-09-25'),
(103, '2024-09-18');

update borrow
set return_date = '2024-10-01'
where reader_id = 1;

update book
set publish_year = 2023
where publish_year >= 2021;

delete from borrow
where borrow_date < '2024-09-18';

select * from book;
select * from reader;
select * from borrow;