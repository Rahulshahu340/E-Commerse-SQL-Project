SELECT * FROM ecommerce.customers;

# Analyze the seasonality of sales to identify peak months.

with cte as
(select year(o.order_delivered_customer_date) years,
month(o.order_delivered_customer_date) as months,
sum(oi.price) as Sales
from orders o
join order_items oi
on oi.order_id = o.order_id
where year(o.order_delivered_customer_date) is not null
group by years, months),

cte_rank as
(Select cte.*, 
dense_rank() over(partition by cte.years order by cte.Sales desc) as RA 
from cte
order by cte.years asc)

Select cte_rank.* from cte_rank
where RA <= 3;

