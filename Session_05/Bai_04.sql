use db_ss5;

alter table Product add sold_quantity int ;

insert into Product
values
(1,'Đồng hồ',1000000,7,'active',2),
(2,'Điện thoại',20000000,7,'active',5),
(3,'latop',1000000,7,'inactive',7),
(4,'Tivi',30000000,7,'inactive',9),
(5,'Điều hòa',2000000,7,'active',3),
(6,'Máy lạnh',5000000,7,'active',11),
(7,'latop',1000000,7,'inactive',23),
(8,'Tivi',30000000,7,'inactive',23),
(9,'Điều hòa',2000000,7,'active',6),
(10,'Máy lạnh',5000000,7,'active',3),
(11,'latop',1000000,7,'inactive',9),
(12,'Tivi',30000000,7,'inactive',2),
(13,'Điều hòa',2000000,7,'active',12),
(14,'Máy lạnh',5000000,7,'active',9),
(15,'latop',1000000,7,'inactive',54),
(16,'Tivi',30000000,7,'inactive',3),
(17,'Điều hòa',200000,7,'active',4),
(18,'Máy lạnh',500000,7,'active',8);

select * from Product
order by sold_quantity desc
limit 10;

select * from Product
order by sold_quantity desc
limit 5 offset 5;

select * from Product
where price<2000000
order by sold_quantity desc;

