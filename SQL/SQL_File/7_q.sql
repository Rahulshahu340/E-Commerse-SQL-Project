SELECT * FROM ecommerce.orders;

# Write a query to find the monthly sales trend for the last two years.

select min(o.order_delivered_customer_date), max(o.order_delivered_customer_date) from orders o;

with cte as
(select 
year(o.order_delivered_customer_date) as years,
month(o.order_delivered_customer_date) as months,
sum(oi.price) as Monthly_sales
from orders o
join order_items oi
on o.order_id = oi.order_id
group by years, months
order by years asc, months asc),

rank_cte as
(Select cte.years,cte.months,cte.Monthly_sales,
dense_rank() over(order by cte.years desc) as RA
from cte)

select rank_cte.years, rank_cte.months,
rank_cte.Monthly_sales from rank_cte
where rank_cte.RA <=2
order by rank_cte.RA asc;



