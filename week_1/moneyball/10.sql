SELECT "first_name", "last_name", "salary", salaries."year", "HR"
FROM players
JOIN salaries ON salaries."player_id" = players."id"
JOIN performances ON salaries."year" = performances."year"
AND performances."player_id" = players."id"
ORDER BY players."id", salaries."year" DESC, "HR" DESC, "salary" DESC;
