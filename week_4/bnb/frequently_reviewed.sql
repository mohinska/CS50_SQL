CREATE VIEW frequently_reviewed AS
SELECT listings."id" AS "id", "property_type", "host_name", COUNT(*) AS "reviews"
FROM listings
JOIN reviews ON reviews."listing_id" = listings."id"
GROUP BY listings."id"
ORDER BY "reviews" DESC, "property_type", "host_name"
LIMIT 100;
