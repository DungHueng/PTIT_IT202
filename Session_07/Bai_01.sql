create database dml_ss7;
use dml_ss7;

create table customers (
id int auto_increment primary key,
full_name varchar(50),
email varchar(50)
);
  
create table orders(
id int auto_increment primary key ,
customer_id int ,
order_date date,
total_amount decimal(10,2),
foreign key (customer_id) references customers(id)
);
 
insert into customers (full_name,email)
values
('Nguyen Van A','NVA@gmail.com'),
('Tran Thi B','TTB@gmail.com'),
('Hoang Van D','HVD@gmail.com'),
('Lo Thi E','LTE@gmail.com');

insert into orders (customer_id,order_date,total_amount)
values
(1,'2026-01-05','100000'),
(2,'2026-01-06','200000'),
(3,'2026-01-03','300000'),
(4,'2026-01-04','400000'),
(1,'2026-01-05','200000'),
(1,'2026-01-04','700000');

select *
from customers
where id in (select customer_id from orders);