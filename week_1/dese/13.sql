SELECT "name", "dropped" FROM "schools"
JOIN "graduation_rates" ON "graduation_rates"."school_id" = "schools"."id"
WHERE "dropped" > (
    SELECT AVG("dropped") FROM "graduation_rates"
)
ORDER BY "dropped" DESC, "name";
