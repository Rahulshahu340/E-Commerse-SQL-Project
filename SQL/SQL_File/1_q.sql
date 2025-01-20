SELECT * FROM ecommerce.order_items;

# Write a query to calculate total sales revenue per category, sub-category, and region.
#(freight value -  refers to the cost associated with transporting goods)
# Therfore can be a part of total sales revenue


SELECT 
    p.product_category,
    c.customer_state,
    SUM(oi.price)  AS Total_sales_revenue
FROM
    order_items oi
        JOIN
    products p ON p.product_id = oi.product_id
        JOIN
    orders o ON o.order_id = oi.order_id
        JOIN
    customers c ON c.customer_id = o.customer_id
WHERE
    o.order_status = 'delivered'
GROUP BY p.product_category , c.customer_state;



