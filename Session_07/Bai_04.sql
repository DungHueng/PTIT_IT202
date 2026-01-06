use dml_ss7;
select full_name ,( select count(customer_id) from orders  where orders.customer_id = customers.id) as total_order
from customers 
where id in (select customer_id from orders );