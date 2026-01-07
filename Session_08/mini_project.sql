create database project;
use project;

create table customers (
    customer_id int auto_increment primary key,
    customer_name varchar(100) not null,
    email varchar(100) not null unique,
    phone varchar(10) not null unique
);

create table categories (
    category_id int auto_increment primary key,
    category_name varchar(255) not null unique
);

create table products (
    product_id int auto_increment primary key,
    product_name varchar(255) not null unique,
    price decimal(10,2) not null check (price > 0),
    category_id int not null,
    foreign key (category_id) references categories(category_id)
);

create table orders (
    order_id int auto_increment primary key,
    customer_id int not null,
    order_date datetime,
    status enum('Pending','Completed','Cancel') default 'Pending',
    foreign key (customer_id) references customers(customer_id)
);

create table order_items (
    order_item_id int auto_increment primary key,
    order_id int,
    product_id int,
    quantity int not null check (quantity > 0),
    foreign key (order_id) references orders(order_id),
    foreign key (product_id) references products(product_id)
);

insert into customers (customer_name, email, phone) values
('a', 'a@gmail.com', '0123456789'),
('b', 'b@gmail.com', '0987654321'),
('c', 'c@gmail.com', '0123498765'),
('d', 'd@gmail.com', '0987612345'),
('e', 'e@gmail.com', '0135798642');

insert into categories (category_name) values
('dien thoai'),
('laptop'),
('phu kien'),
('may tinh bang'),
('thiet bi mang');

insert into products (product_name, price, category_id) values
('iphone 17', 20000000, 1),
('samsung s25', 18000000, 1),
('macbook air m1', 25000000, 2),
('dell xps 13', 27000000, 2),
('chuot logitech', 500000, 3),
('ban phim co', 1500000, 3),
('ipad air', 16000000, 4),
('router tp-link', 1200000, 5);

insert into orders (customer_id, order_date, status) values
(1, '2025-01-01 10:00:00', 'Completed'),
(1, '2025-01-03 14:30:00', 'Pending'),
(2, '2025-01-05 09:15:00', 'Completed'),
(3, '2025-01-06 16:00:00', 'Cancel'),
(4, '2025-01-07 11:20:00', 'Completed');

insert into order_items (order_id, product_id, quantity) values
(1, 1, 1),
(1, 5, 2),
(2, 2, 1),
(2, 6, 1),
(3, 3, 1),
(3, 5, 1),
(4, 7, 2),
(5, 4, 1),
(5, 8, 3);

select *
from categories;

select *
from orders
where status = 'Completed';

select *
from products
order by price desc;

select *
from products
order by price desc
limit 5 offset 2;

select p.product_id, p.product_name, p.price, c.category_name
from products p
join categories c on p.category_id = c.category_id;

select o.order_id, o.order_date, c.customer_name, o.status
from orders o
join customers c on o.customer_id = c.customer_id;

select o.order_id, sum(oi.quantity) as total_quantity
from orders o
join order_items oi on o.order_id = oi.order_id
group by o.order_id;

select c.customer_id, c.customer_name, count(o.order_id) as total_orders
from customers c
left join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name;

select c.customer_id, c.customer_name, count(o.order_id) as total_orders
from customers c
join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name
having count(o.order_id) >= 2;

select c.category_name,
       avg(p.price) as avg_price,
       min(p.price) as min_price,
       max(p.price) as max_price
from categories c
join products p on c.category_id = p.category_id
group by c.category_name;

select *
from products
where price > (
    select avg(price)
    from products
);

select *
from customers
where customer_id in (
    select distinct customer_id
    from orders
);

select o.order_id, sum(oi.quantity) as total_quantity
from orders o
join order_items oi on o.order_id = oi.order_id
group by o.order_id
having sum(oi.quantity) = (
    select max(total_qty)
    from (
        select sum(quantity) as total_qty
        from order_items
        group by order_id
    ) as temp
);

select distinct c.customer_name
from customers c
join orders o on c.customer_id = o.customer_id
join order_items oi on o.order_id = oi.order_id
join products p on oi.product_id = p.product_id
where p.category_id = (
    select category_id
    from products
    group by category_id
    order by avg(price) desc
    limit 1
);

select t.customer_id, c.customer_name, sum(t.total_quantity) as total_purchased
from (
    select o.customer_id, sum(oi.quantity) as total_quantity
    from orders o
    join order_items oi on o.order_id = oi.order_id
    group by o.order_id, o.customer_id
) as t
join customers c on t.customer_id = c.customer_id
group by t.customer_id, c.customer_name;

select *
from products
where price = (
    select max(price)
    from products
);

