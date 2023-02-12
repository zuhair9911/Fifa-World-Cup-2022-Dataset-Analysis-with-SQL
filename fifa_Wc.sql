SELECT * FROM stats;

#Total numbers of goals scored
Select ( SUM(`number of goals team1`) + SUM(`number of goals team2`) ) as Total_goals
from stats;

#Top 5 highest scoring teams
Select  team, Sum(goals) as total_goals
from(
SELECT team1 as team, `number of goals team1` as goals
FROM stats
UNION ALL
SELECT team2 as team, `number of goals team2` as goals
FROM stats
) subquery
group by team
ORDER BY total_goals DESC LIMIT 5;

#Top 5 teams with highest goal per game ratio
Select  team, Sum(goals) as total_goals, Count(team) as Number_of_matches,
SUM(goals)/Count(team) as goal_per_game
from(
SELECT team1 as team, `number of goals team1` as goals
FROM stats
UNION ALL
SELECT team2 as team, `number of goals team2` as goals
FROM stats
) subquery
group by team
ORDER BY goal_per_game DESC LIMIT 5;

#Top 5 teams with most goals conceded
Select  team, Sum(goals_conceded) as total_goals_conceded
from(
SELECT team1 as team, `conceded team1` as goals_conceded
FROM stats
UNION ALL
SELECT team2 as team, `conceded team2` as goals_conceded
FROM stats
) subquery
group by team
ORDER BY total_goals_conceded DESC LIMIT 5;

#Analyzing goal attempts and possible xG
Select team, SUM(total_attempts) as total_attempted_shots, SUM(attempts_on_target) as on_target
from (
SELECT team1 as team, `total attempts team1` as total_attempts, 
`on target attempts team1` as attempts_on_target
from stats
UNION ALL
Select team2 as team, `total attempts team2` as total_attempts,
`on target attempts team2` as attempts_on_target
from stats ) subquery
group by team
order by total_attempted_shots DESC;


#Inbehind offers
#Interestingly, france having two of the fastest wingers are fourth on total inbehind offers recieved.
Select  team, Sum(inbehind_offers) as inbehind_offers_recieved
from(
SELECT team1 as team, `inbehind offers to receive team1` as inbehind_offers
FROM stats
UNION ALL
SELECT team2 as team, `inbehind offers to receive team2` as inbehind_offers
FROM stats
) subquery
group by team
ORDER BY inbehind_offers_recieved DESC LIMIT 5;

#Analyzing press
#Morroco was the team with second highest forced turnovers in the tournament, one of the majore reasons they did so well.
Select  team, Sum(forced_turnovers) as turnovers_forced
from(
SELECT team1 as team, `forced turnovers team1` as forced_turnovers
FROM stats
UNION ALL
SELECT team2 as team, `forced turnovers team2` as forced_turnovers
FROM stats
) subquery
group by team
ORDER BY turnovers_forced DESC LIMIT 5;



