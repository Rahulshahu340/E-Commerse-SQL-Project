SELECT * FROM ecommerce.orders;
select * from order_items;

# Identify regions or products with the highest delivered rates. = (No. of Orders delivered/ Total no pf orders places) * 100

with cte as
	(SELECT 
		c.customer_state as Region,
        count(oi.order_id) AS delivered_orders
	FROM customers c 
    JOIN orders o ON c.customer_id = o.customer_id
	JOIN order_items oi ON oi.order_id = o.order_id
	WHERE
		o.order_status = 'delivered'
	GROUP BY c.customer_state),
    
cte_total_orders as 
	(Select 
		c.customer_state as Region,
		count(oi.order_id) as Total_orders 
	FROM customers c
	JOIN orders o ON c.customer_id = o.customer_id
	JOIN order_items oi ON oi.order_id = o.order_id
	group by c.customer_state)

Select cte.Region,
((cte.delivered_orders/cte_total_orders.Total_orders)* 100) as Delivery_Rate
from cte join cte_total_orders 
on cte.Region = cte_total_orders.Region
order by Delivery_Rate desc;


