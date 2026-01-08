create table empp(
emp_id int,
emp_name varchar(20),
department_id int,
salary int,
manager_id int,
emp_age int);

insert into empp
values
(1, 'Ankit', 100,10000, 4, 39),
(2, 'Mohit', 100, 15000, 5, 48),
(3, 'Vikas', 100, 10000,4,37),
(4, 'Rohit', 100, 5000, 2, 16),
(5, 'Mudit', 200, 12000, 6,55),
(6, 'Agam', 200, 12000,2, 14),
(7, 'Sanjay', 200, 9000, 2,13),
(8, 'Ashish', 200,5000,2,12),
(9, 'Mukesh',300,6000,6,51),
(10, 'Rakesh',300,7000,6,50),
(11, 'Suresh',300,8000,6,50);

-- Solution

with t1 as (
			select *,
					row_number() over(partition by department_id order by salary) as rn_asc,
					row_number() over(partition by department_id order by salary desc) as rn_desc
			from empp
			)
select department_id, round(avg(salary),2) median_salary
from t1
where abs(rn_asc - rn_desc) <= 1
group by department_id


