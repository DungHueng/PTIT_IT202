use dml_ss7;
select c.* ,sum(total_amount)  as `total money`
from customers c 
join orders o on c.id = o.customer_id
group by c.id
having sum(total_amount) = (
select sum(total_amount) from orders
group by customer_id
order by sum(total_amount) desc limit 1
);