/*1.¿Cuántas tablas tiene la base de datos? (uso de consultas select)*/

SELECT *
FROM sqlite_master
WHERE type='table';

/*2.¿Cuántos jugadores hay en la base de datos?*/
SELECT 
count(id)
FROM Player;

/*3.¿Cuáles son los 10 primeros jugadores en la tabla player?*/
SELECT *
FROM Player
LIMIT 10;

/*8. ¿Cuántos países hay? ¿Cuántos jugadores hay en cada país?*/
SELECT 
count(id)
FROM Country;

SELECT
C.name PAIS,
count(country_id) 
FROM Match M
LEFT JOIN Country C on M.country_id = C.id
GROUP by country_id
ORDER BY C.name ASC;

/*9. ¿Cuántas ligas hay?*/
SELECT
count(id)
FROM League;

/*10. ¿Cuántas ligas hay por país?*/

SELECT
C.name PAIS,
count(country_id) NUM_LIGAS
FROM League L
LEFT JOIN Country C ON L.country_id = C.id
GROUP BY country_id
ORDER BY C.name ASC;


SELECT
	M.id,
	C.name AS PAIS,
	L.name AS LIGA,
	M.season AS TEMPORADA,
	M.stage,
	M.date AS FECHA,
	T.team_long_name AS EQUIPO_LOCAL,
	TE.team_long_name AS EQUIPO_VISITANTE,
	M.home_team_goal,
	M.away_team_goal
FROM Match M
JOIN Country C ON C.id = M.country_id
JOIN League L ON L.id = M.league_id
LEFT JOIN Team T ON T.team_api_id = M.home_team_api_id
LEFT JOIN Team TE ON TE.team_api_id = M.away_team_api_id
WHERE C.name = "Spain"
LIMIT 10;

SELECT
	C.name,
	L.name, 
	count(DISTINCT stage),
	count(DISTINCT T.team_long_name),
	avg(home_team_goal),
	avg(away_team_goal),
	avg(home_team_goal-away_team_goal),
	avg(home_team_goal+away_team_goal),
	sum(home_team_goal+away_team_goal)
FROM Match
JOIN Country C ON C.id = M.country_id
JOIN League L ON L.id = M.league_id
LEFT JOIN Team T ON T.team_api_id = M.home_team_api_id
LEFT JOIN Team TE ON TE.team_api_id = M.away_team_api_id