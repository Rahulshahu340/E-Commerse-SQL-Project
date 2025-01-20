SELECT * FROM ecommerce.orders;

# Analyze delivery performance by calculating the average delivery time by region.

SELECT 
    c.customer_state,
    c.customer_city,
    AVG(DATEDIFF(o.order_delivered_customer_date,
            o.order_purchase_timestamp)) AS avg_del_time_in_days
FROM
    customers c
        JOIN
    orders o ON o.customer_id = c.customer_id
WHERE
    o.order_delivered_customer_date IS NOT NULL
GROUP BY c.customer_state , c.customer_city
ORDER BY c.customer_state ASC , avg_del_time_in_days asc;