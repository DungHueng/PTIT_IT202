
use db_ss5;
create table Customers(
customer_id int primary key,
full_name varchar(255),
email varchar(255) ,
city varchar(255),
status enum('active','inactive')
);

insert into Customers
values
(1, 'Nguyễn Văn An', 'an.nguyen@gmail.com', 'Hà Nội', 'active'),
(2, 'Trần Thị Bình', 'binh.tran@gmail.com', 'TP.HCM', 'active'),
(3, 'Lê Văn Cường', 'cuong.le@gmail.com', 'Hà Nội', 'inactive'),
(4, 'Phạm Thị Dung', 'dung.pham@gmail.com', 'Hải Phòng', 'active'),
(5, 'Hoàng Văn Em', 'em.hoang@gmail.com', 'Cần Thơ', 'inactive'),
(6, 'Vũ Thị Hoa', 'hoa.vu@gmail.com', 'TP.HCM', 'active'),
(7, 'Đỗ Văn Khánh', 'khanh.do@gmail.com', 'Nha Trang', 'active'),
(8, 'Bùi Thị Lan', 'lan.bui@gmail.com', 'Hà Nội', 'inactive');

select * from Customers;

select * from Customers
where city='TP.HCM';

select * from Customers
where city='Hà Nội' and status='active';

select * from Customers
order by full_name asc;