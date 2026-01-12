create table players
(player_id int,
group_id int);

insert into players values (15,1);
insert into players values (25,1);
insert into players values (30,1);
insert into players values (45,1);
insert into players values (10,2);
insert into players values (35,2);
insert into players values (50,2);
insert into players values (20,3);
insert into players values (40,3);

create table matches
(
match_id int,
first_player int,
second_player int,
first_score int,
second_score int);

insert into matches values (1,15,45,3,0);
insert into matches values (2,30,25,1,2);
insert into matches values (3,30,15,2,0);
insert into matches values (4,40,20,5,2);
insert into matches values (5,35,50,1,1);

-- Solution

with player_scores as (
						select player, sum(score) as sum_scores
						from (
								select first_player as player, first_score as score
								from matches
								union all
								select second_player as player, second_score as score
								from matches
							  )
						group by player
						order by player
						),
		score_rank as (
						select player_id, group_id, sum_scores,
								dense_rank() over(partition by group_id order by sum_scores desc, player_id asc) as score_rank
						from player_scores ps
						join players p
						on ps.player = p.player_id
					   )
select group_id, player_id, sum_scores as score
from score_rank
where score_rank = 1
 




