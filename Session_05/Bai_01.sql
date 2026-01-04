create database db_ss5;

use db_ss5;

create table Product(
product_id int primary key ,
product_name varchar(255) not null ,
price  decimal(10,2),
stook int ,
status enum('active','inactive')
);

insert into Product
values
(1,'Đồng hồ',1000000,7,'active'),
(2,'Điện thoại',20000000,7,'active'),
(3,'latop',1000000,7,'inactive'),
(4,'Tivi',30000000,7,'inactive'),
(5,'Điều hòa',2000000,7,'active'),
(6,'Máy lạnh',5000000,7,'active');

select * from Product;

select * from Product
where status ='active';

select * from Product
where price>1000000;

select * from Product
where status ='active'
order by price asc;
