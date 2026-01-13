create table userr
(
user_id integer,
name varchar(20),
join_date date
);
insert into userr
values (1, 'Jon', CAST('2-14-20' AS date)), 
(2, 'Jane', CAST('2-14-20' AS date)), 
(3, 'Jill', CAST('2-15-20' AS date)), 
(4, 'Josh', CAST('2-15-20' AS date)), 
(5, 'Jean', CAST('2-16-20' AS date)), 
(6, 'Justin', CAST('2-17-20' AS date)),
(7, 'Jeremy', CAST('2-18-20' AS date));

create table events
(
user_id integer,
type varchar(10),
access_date date
);

insert into events values
(1, 'Pay', CAST('3-1-20' AS date)), 
(2, 'Music', CAST('3-2-20' AS date)), 
(2, 'P', CAST('3-12-20' AS date)),
(3, 'Music', CAST('3-15-20' AS date)), 
(4, 'Music', CAST('3-15-20' AS date)), 
(1, 'P', CAST('3-16-20' AS date)), 
(3, 'P', CAST('3-22-20' AS date));

select * from userr;
select * from events;


select *
from userr 
where user_id in (select user_id
				 from events
				 where type in ('P','Music'))

select count(distinct u.user_id) as total_users,  
	   count(distinct case when (access_date - join_date) <= 30 then u.user_id end) as day_diff,
	   round(1.0 * count(distinct case when (access_date - join_date) <= 30 then u.user_id end)/count(distinct u.user_id)* 100, 2)
from userr u
left join events e
on u.user_id = e.user_id and type = 'P'
where u.user_id in (select user_id 
				  from events
				  where type = 'Music')

--------------------------------------------------------------------------
select u.user_id, name, join_date, e.user_id, type, access_date
from userr u 
left join events e 
on u.user_id = e.user_id and type = 'P'
where u.user_id in (
                  select user_id
                  from events
                  where type = 'Music')
