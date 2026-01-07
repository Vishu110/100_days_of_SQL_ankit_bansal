select sum(sales)*0.8
from orders

with product_wise_sales as (
					select product_id, round(sum(sales)::numeric,2) product_sales
					from orders
					group by product_id
				   ),
     calc_sales as (
					select *,
							round(sum(product_sales) over(order by product_sales desc)::numeric,2) as running_sales,
							round(0.8 * sum(product_sales) over()::numeric,2) as total_sales
					from product_wise_sales
					)
select *
from calc_sales
where running_sales <= total_sales
