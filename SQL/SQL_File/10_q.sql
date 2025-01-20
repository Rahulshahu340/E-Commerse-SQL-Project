SELECT * FROM ecommerce.order_items;
select count(distinct(order_delivered_customer_date)) from orders;
select count(order_delivered_customer_date) from orders;

# Calculate month-to-date (MTD) and year-to-date (YTD) sales metrics.

-- The delivered_customer_date has multiple enteries for a particular date,
-- SO we will make use of Rows parameter with (unbounded precedings and current row) as YTD_Frame

select 
	oi.order_id,
	date(o.order_delivered_customer_date) as dates ,
    year(o.order_delivered_customer_date) as years ,
    month(o.order_delivered_customer_date) as months ,
    oi.price,
	sum(oi.price) over(partition by year(o.order_delivered_customer_date) 
					   order by date(o.order_delivered_customer_date)) as YTD,
    sum(oi.price) over(partition by year(o.order_delivered_customer_date)
					   order by date(o.order_delivered_customer_date)
    Rows between unbounded preceding and current row) as YTD_Frame,
    sum(oi.price) over(partition by month(o.order_delivered_customer_date)
					   order by date(o.order_delivered_customer_date)) as MTD,
    sum(oi.price) over(partition by month(o.order_delivered_customer_date)
					   order by date(o.order_delivered_customer_date)
    Rows between unbounded preceding and current row) as MTD_Frame
from order_items oi
join orders o 
on o.order_id = oi.order_id
where date(o.order_delivered_customer_date) is not null;