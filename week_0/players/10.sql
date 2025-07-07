SELECT "first_name" || ' ' ||  "last_name" AS "Highest players in US"
FROM "players"
WHERE "birth_country" != 'USA'
ORDER BY "height" DESC LIMIT 10;
