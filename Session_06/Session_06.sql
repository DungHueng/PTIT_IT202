create database dml_ss6;
use dml_ss6;

create table customers(
customer_id int primary key,
full_name varchar(255),
city varchar(255)
);

create table orders (
order_id int primary key,
customer_id int,
order_date date,
`status` enum('pending', 'completed', 'cancelled'),
constraint fk_orders_customers
foreign key (customer_id) references customers(customer_id),
total_amount decimal(10, 2)
);

create table products(
product_id int primary key,
product_name varchar(255),
price decimal(10, 2)
);

create table order_items(
order_id int,
product_id int,
quantity int,
constraint fk_items_orders
foreign key (order_id) references orders(order_id),
constraint fk_items_products
foreign key (product_id) references products(product_id)
);

insert into customers(customer_id, full_name, city)
values
(1, 'Nguyen Van A', 'Ha Noi'),
(2, 'Tran Thi B', 'Thanh Hoa'),
(3, 'Bui Van C', 'Lao Cai'),
(4, 'Nguyen The D', 'Da Nang'),
(5, 'Lo Van E', 'Ho Chi Minh');

insert into orders(order_id, customer_id, order_date, `status`)
values
(1, 1, '2022-12-22', 'pending'),
(2, 1, '2012-09-21', 'completed'),
(3, 1, '2024-01-10', 'pending'),
(4, 2, '2016-11-23', 'completed'),
(5, 4, '2020-06-19', 'cancelled');

insert into products(product_id, product_name, price)
values
(1, 'samsung', 1500000),
(2, 'Iphone', 67000000),
(3, 'ban phim co', 120000),
(4, 'nintendo switch', 3600000),
(5, 'playstation 5', 67000000);

insert into order_items(order_id, product_id, quantity)
values
(1, 1, 1),
(1, 2, 3),
(2, 1, 4),
(2, 3, 4),
(4, 5, 1),
(5, 1, 2);

update orders set total_amount = 6700000 where order_id = 1;
update orders set total_amount = 2000000 where order_id = 2;
update orders set total_amount = 3600000 where order_id = 3;
update orders set total_amount = 1000000 where order_id = 4;
update orders set total_amount = 6900000 where order_id = 5;

#Bài 1:
-- Hiển thị danh sách đơn hàng kèm tên khách hàng
select o.order_id, o.order_date, o.status, c.full_name
from orders o
inner join customers c on o.customer_id = c.customer_id;

-- Hiển thị mỗi khách hàng đã đặt bao nhiêu đơn hàng
select c.customer_id, c.full_name, count(o.order_id) as total_orders
from customers c
left join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.full_name;

-- Hiển thị các khách hàng có ít nhất 1 đơn hàng
select c.customer_id, c.full_name, count(o.order_id) as total_orders
from customers c
inner join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.full_name
having count(o.order_id) >= 1;

#Bài 2:
-- Hiển thị tổng tiền khách hàng đã chi tiêu
select c.customer_id, c.full_name, sum(o.total_amount) as total_price
from customers c
inner join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.full_name;

-- Hiển thị giá trị đơn hàng cao nhất của từng khách
select c.customer_id, c.full_name, max(o.total_amount) as highest_total_price
from customers c
inner join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.full_name;

-- sắp xếp dánh sách khách hàng theo tổng tiền giảm dần
select c.customer_id, c.full_name, sum(o.total_amount) as total_lower
from customers c
inner join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.full_name
order by total_lower desc;

#Bài 3:
-- Tính tổng doanh thu theo từng ngày
select order_date, sum(total_amount) as total_complete
from orders
where status = 'completed'
group by order_date;

-- Tính số lượng đơn hàng theo từng ngày
select order_date, count(order_id) as order_quantity
from orders
where status = 'completed'
group by order_date;

-- Chỉ hiển thị các ngày có doanh thu > 10.000.000
select order_date, sum(total_amount) as total_revenue
from orders
where status = 'completed'
group by order_date
having sum(total_amount) > 10000000;

#Bài 4:
-- Hiển thị mỗi sản phẩm đã bán được bao nhiêu sản phẩm
select p.product_id, p.product_name, sum(oi.quantity) as total_sold
from products p
join order_items oi 
on p.product_id = oi.product_id
group by p.product_id, p.product_name;

-- Tính doanh thu của từng sản phẩm
select p.product_id, p.product_name, sum(oi.quantity * p.price) as total_products
from products p
join order_items oi 
on p.product_id = oi.product_id
group by p.product_id, p.product_name;

-- Chỉ hiển thị các sản phẩm có doanh thu > 5.000.000
select p.product_id, p.product_name, sum(oi.quantity * p.price) as highest_price
from products p
join order_items oi 
on p.product_id = oi.product_id
group by p.product_id, p.product_name
having sum(oi.quantity * p.price) > 5000000;

#Bài 5:
select c.customer_id, c.full_name, count(o.order_id) as total_orders, sum(o.total_amount) as total_spending, 
avg(o.total_amount) as avg_highest
from customers c
join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.full_name
having count(o.order_id) >= 3 and sum(o.total_amount) > 10000000
order by total_spending desc;