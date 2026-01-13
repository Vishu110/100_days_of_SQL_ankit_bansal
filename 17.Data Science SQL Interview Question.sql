create table ordersss
(
order_id int,
customer_id int,
product_id int
);

insert into ordersss VALUES 
(1, 1, 1),
(1, 1, 2),
(1, 1, 3),
(2, 2, 1),
(2, 2, 2),
(2, 2, 4),
(3, 1, 5);

create table products (
id int,
name varchar(10)
);
insert into products VALUES 
(1, 'A'),
(2, 'B'),
(3, 'C'),
(4, 'D'),
(5, 'E');

-- Solution

select p1.name || ' ' || p2.name as pair, count(*) purchase_freq
from ordersss o1
join ordersss o2
on o1.order_id = o2.order_id
join products p1
on o1.product_id = p1.id 
join products p2
on o2.product_id = p2.id 
where o1.product_id < o2.product_id
group by p1.name, p2.name
