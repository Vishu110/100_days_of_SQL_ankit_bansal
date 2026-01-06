create table icc_world_cup
(
Team_1 Varchar(20),
Team_2 Varchar(20),
Winner Varchar(20)
);
INSERT INTO icc_world_cup values('India','SL','India');
INSERT INTO icc_world_cup values('SL','Aus','Aus');
INSERT INTO icc_world_cup values('SA','Eng','Eng');
INSERT INTO icc_world_cup values('Eng','NZ','NZ');
INSERT INTO icc_world_cup values('Aus','India','India');

select *
from icc_world_cup

-- Solution

select team_name, count(*) no_of_matches_played, sum(win_flag) no_of_matches_won, count(*) - sum(win_flag) no_of_losses
from        
    (select team_1 team_name, 
            case when team_1 = Winner then 1
            else 0 
            end as win_flag
    from icc_world_cup
    union all
    select team_2 team_name, 
            case when team_2 = Winner then 1
            else 0 
            end as win_flag
    from icc_world_cup) A
    group by team_name
    order by no_of_matches_won desc


