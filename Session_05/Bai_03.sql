use db_ss5;
create table Orders(
order_id int primary key,
customer_id int ,
total_amount decimal(10,2),
order_date date ,
statust enum ('pending', 'completed', 'cancelled'),
foreign key (customer_id) references Customers(customer_id)
);

insert into Orders
values
(1, 1, 7500000, '2024-01-05', 'completed'),
(2, 2, 2300000, '2024-01-10', 'completed'),
(3, 3,  750000, '2024-01-12', 'pending'),
(4, 4, 3200000, '2024-01-15', 'completed'),
(5, 5,  980000, '2024-01-18', 'cancelled'),
(6, 1, 1250000, '2024-01-20', 'completed'),
(7, 6, 4500000, '2024-01-22', 'pending'),
(8, 7, 21000000 ,'2024-01-25', 'completed'),
(9, 8,  890000, '2024-01-27', 'cancelled'),
(10, 2, 5600000, '2024-01-30', 'completed');

select * from Orders;

select * from Orders
where total_amount>5000000;

select * from Orders
order by order_date desc
limit 5;

select * from Orders
where statust='completed'
order by order_date desc;