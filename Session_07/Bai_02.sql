use dml_ss7;
create table products (
id int auto_increment primary key,
name_products varchar(50) ,
price decimal(10,2)
);

create table order_items(
order_id int auto_increment primary key,
product_id int ,
quantity int ,
foreign key (product_id) references products(id)
);

insert into products (name_products, price)
 values
('Bút bi', 5000),
('Vở viết', 12000),
('Thước kẻ', 7000),
('Tẩy', 3000),
('Balo', 150000);

insert into order_items (product_id, quantity)
 values
(1, 10),
(2, 5),
(3, 3),
(4, 20);

select*
 from products
 where id in (select product_id from order_items)