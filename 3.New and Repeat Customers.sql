create table customer_orders (
order_id integer,
customer_id integer,
order_date date,
order_amount integer
);

insert into customer_orders values(1,100,cast('2022-01-01' as date),2000),(2,200,cast('2022-01-01' as date),2500),(3,300,cast('2022-01-01' as date),2100)
,(4,100,cast('2022-01-02' as date),2000),(5,400,cast('2022-01-02' as date),2200),(6,500,cast('2022-01-02' as date),2700)
,(7,100,cast('2022-01-03' as date),3000),(8,400,cast('2022-01-03' as date),1000),(9,600,cast('2022-01-03' as date),3000);

--Solution

with t1 as (
			select order_id, co.customer_id, order_date, order_amount, min_order_date
			from customer_orders co
			join (
					select customer_id, min(order_date) min_order_date
					from customer_orders
					group by customer_id) mco
			on co.customer_id = mco.customer_id
			)
select order_date,
		sum(case when order_date = min_order_date then 1 else 0 end) as new_customers_flag,
		sum(case when order_date != min_order_date then 1 else 0 end) as repeat_customers_flag
from t1
group by order_date
order by order_date