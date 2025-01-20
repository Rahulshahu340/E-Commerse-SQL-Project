SELECT * FROM ecommerce.products;

# Use window functions to rank products based on their sales within each category.

with cte as
(select p.product_category as category, p.product_id, 
sum(oi.price) as sales 
from products p
join order_items oi
on oi.product_id = p.product_id
where p.product_category is not null
group by  p.product_category, p.product_id
order by p.product_category asc, sales desc)

select cte.*, dense_rank()
 over(partition by cte.category order by cte.sales desc) as RA from cte;