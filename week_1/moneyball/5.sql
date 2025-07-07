SELECT "name"
FROM teams
JOIN performances ON performances."team_id" = teams."id"
JOIN players ON players."id" = performances."player_id"
WHERE players."id" = (
    SELECT "id"
    FROM players
    WHERE "first_name" = 'Satchel'
    AND "last_name" = 'Paige'
)
GROUP BY "name";
