-- Tables

Teams table:
+---------+-----------+
| team_id | team_name |
+---------+-----------+
| 1       | Ajax      |
| 4       | Dortmund  |
| 6       | Arsenal   |
+---------+-----------+

Matches table:
+--------------+--------------+-----------------+-----------------+
| home_team_id | away_team_id | home_team_goals | away_team_goals |
+--------------+--------------+-----------------+-----------------+
| 1            | 4            | 0               | 1               |
| 1            | 6            | 3               | 3               |
| 4            | 1            | 5               | 2               |
| 6            | 1            | 0               | 0               |
+--------------+--------------+-----------------+-----------------+


Result table:
+-----------+----------------+--------+----------+--------------+-----------+
| team_name | matches_played | points | goal_for | goal_against | goal_diff |
+-----------+----------------+--------+----------+--------------+-----------+
| Dortmund  | 2              | 6      | 6        | 2            | 4         |
| Arsenal   | 2              | 2      | 3        | 3            | 0         |
| Ajax      | 4              | 2      | 5        | 9            | -4        |

-- QUERY

WITH cte_1
     AS (SELECT b.team_name AS home_team_name,
                c.team_name AS away_team_name,
                a.home_team_goals,
                a.away_team_goals,
                CASE
                  WHEN home_team_goals < away_team_goals THEN c.team_name
                  WHEN home_team_goals > away_team_goals THEN b.team_name
                  WHEN home_team_goals = away_team_goals THEN 'Draw'
                  ELSE NULL
                END         AS match_result
         FROM   randomtables.matches a
                INNER JOIN randomtables.team b
                        ON a.home_team_id = b.team_id
                INNER JOIN randomtables.team c
                        ON a.away_team_id = c.team_id),
     pts
     AS (SELECT *,
                CASE
                  WHEN match_result = home_team_name THEN 3
                  WHEN match_result = 'Draw' THEN 1
                  ELSE 0
                END AS pts_home_team,
                CASE
                  WHEN match_result = away_team_name THEN 3
                  WHEN match_result = 'Draw' THEN 1
                  ELSE 0
                END AS pts_away_team
         FROM   cte_1),
     cte_2
     AS (SELECT home_team_name,
                Sum(pts_home_team)    AS pts_home,
                Count(home_team_name) AS n_home_mts,
                Sum(home_team_goals)  AS goals_for,
                Sum(away_team_goals)  AS goals_against
         FROM   pts
         GROUP  BY 1),
     cte_3
     AS (SELECT away_team_name,
                Sum(pts_away_team)    AS pts_away,
                Count(away_team_name) AS n_away_mts,
                Sum(away_team_goals)  AS goals_for,
                Sum(home_team_goals)  AS goals_against
         FROM   pts
         GROUP  BY 1)
SELECT home_team_name                              AS team,
       n_home_mts + n_away_mts                     AS matches_played,
       pts_home + pts_away                         AS points,
       cte_2.goals_for + cte_3.goals_for           AS goals_for,
       cte_2.goals_against + cte_3.goals_against   AS goals_against,
       ( cte_2.goals_for + cte_3.goals_for ) - (
       cte_2.goals_against + cte_3.goals_against ) AS goal_difference
FROM   cte_2,
       cte_3
WHERE  home_team_name = away_team_name
ORDER  BY goal_difference DESC
