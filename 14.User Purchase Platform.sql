create table spending 
(
user_id int,
spend_date date,
platform varchar(10),
amount int
);

insert into spending values
							(1,'2019-07-01','mobile',100),
							(1,'2019-07-01','desktop',100),
							(2,'2019-07-01','mobile',100),
							(2,'2019-07-02','mobile',100),
							(3,'2019-07-01','desktop',100),
							(3,'2019-07-02','desktop',100);


-- Solution

with spend as (
				select  spend_date, user_id, max(platform) as platform, sum(amount) as amount
				from spending
				group by user_id, spend_date
				having count(distinct platform) = 1
				union all
				select  spend_date,user_id, 'both' as platform, sum(amount) as amount
				from spending
				group by user_id, spend_date
				having count(distinct platform) = 2
				union all
				select distinct spend_date, null::numeric as user_id, 'both' as platform, 0 as amount
				from spending 
				order by spend_date, user_id
				)
select  spend_date, platform, sum(amount) as amount, count(distinct user_id) as total_users
from spend
group by spend_date, platform
order by spend_date
