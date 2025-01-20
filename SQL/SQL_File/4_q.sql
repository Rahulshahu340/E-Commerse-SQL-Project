SELECT * FROM ecommerce.customers;

# Identify customers with the highest average order value (AOV). = ((sum)Toatl revenue/(count)Total no of orders)

SELECT 
    c.customer_id,
    (SUM(oi.price) / COUNT(DISTINCT (o.order_id))) AS AOV
FROM
    customers c
        JOIN
    orders o ON o.customer_id = c.customer_id
        JOIN
    order_items oi ON oi.order_id = o.order_id
WHERE
    o.order_status = 'delivered'
GROUP BY c.customer_id
ORDER BY AOV DESC
LIMIT 10;


