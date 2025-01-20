SELECT * FROM ecommerce.customers;

# Find the most loyal customers by calculating their purchase frequency(Total no of orders/ distinct(total no of customers) and total spend.
select min(order_delivered_customer_date), max(order_delivered_customer_date) from orders;

SELECT 
    c.customer_id,
    (COUNT(o.order_id) / COUNT(DISTINCT (c.customer_id))) AS purchase_freq,
    SUM(oi.price) AS total_spend
FROM
    customers c
        JOIN
    orders o ON o.customer_id = c.customer_id
        JOIN
    order_items oi ON oi.order_id = o.order_id
WHERE
    o.order_delivered_customer_date BETWEEN '2016-10-11 13:46:32' AND '2018-10-17 13:22:46'
GROUP BY customer_id
ORDER BY purchase_freq DESC , total_spend DESC
LIMIT 10;