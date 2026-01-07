create table empl(emp_id int,emp_name varchar(10),salary int ,manager_id int);

insert into empl values(1,'Ankit',10000,4);
insert into empl values(2,'Mohit',15000,5);
insert into empl values(3,'Vikas',10000,4);
insert into empl values(4,'Rohit',5000,2);
insert into empl values(5,'Mudit',12000,6);
insert into empl values(6,'Agam',12000,2);
insert into empl values(7,'Sanjay',9000,2);
insert into empl values(8,'Ashish',5000,2);

-- Solution

select manager_id, round(avg(salary),2) avg_salary
from empl
where salary > 5000
group by manager_id
having avg(salary) > 10000