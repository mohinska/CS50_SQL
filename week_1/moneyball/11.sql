SELECT "first_name", "last_name", "salary" / "H" AS "dollars per hit"
FROM players
JOIN performances ON performances."player_id" = players."id"
JOIN salaries ON salaries."player_id" = players."id"
AND salaries."year" = performances."year"
WHERE salaries."year" = 2001
AND "H" != 0
ORDER BY "dollars per hit", "first_name", "last_name"
LIMIT 10;
