CREATE VIEW june_vacancies AS
SELECT listings."id" AS "id", "property_type", "host_name", COUNT(*) AS "days_vacant"
FROM listings
JOIN availabilities ON availabilities."listing_id" = listings."id"
WHERE "available" = 'TRUE'
AND "date" LIKE '2023-07-%'
GROUP BY listings."id";
