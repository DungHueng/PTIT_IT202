
use db_ss5;
select *
from Orders
where statust <> 'cancelled'
limit 5 offset 0;

select *
from Orders
where statust <> 'cancelled'
limit 5 offset 5;

select *
from Orders
where statust <> 'cancelled'
limit 5 offset 10;
