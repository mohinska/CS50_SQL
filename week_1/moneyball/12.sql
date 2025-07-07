SELECT "first_name", "last_name"
FROM players
WHERE "id" IN (
    SELECT players."id"
    FROM players
    JOIN performances ON performances."player_id" = players."id"
    JOIN salaries ON salaries."player_id" = players."id"
    AND salaries."year" = performances."year"
    WHERE salaries."year" = 2001
    AND "H" != 0
    ORDER BY "salary" / "H", "first_name", "last_name"
    LIMIT 10
)

INTERSECT

SELECT "first_name", "last_name"
FROM players
WHERE "id" IN (
    SELECT players."id"
    FROM players
    JOIN performances ON performances."player_id" = players."id"
    JOIN salaries ON salaries."player_id" = players."id"
    AND salaries."year" = performances."year"
    WHERE salaries."year" = 2001
    AND "RBI" != 0
    ORDER BY "salary" / "RBI", "first_name", "last_name"
    LIMIT 10
)

ORDER BY "last_name";
