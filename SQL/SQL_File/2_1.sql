
# # Identify the top 5 best-selling products by both sales revenue and quantity sold.

with cte as(
select 
	p.product_id,
	p.product_category,
    count(oi.price) as qty_sold, 
    sum(oi.price) as sales_revenue,
dense_rank() over(order by sum(oi.price) desc , count(oi.price) desc) as RA
from products p
	join order_items oi
	on p.product_id = oi.product_id
group by p.product_id,p.product_category
order by qty_sold desc, sales_revenue desc)

Select cte.* from cte
where cte.RA <= 5
order by RA;