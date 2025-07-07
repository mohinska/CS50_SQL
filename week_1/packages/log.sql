
-- *** The Lost Letter ***
SELECT "address", "type" FROM "addresses"
WHERE "id" = (
    SELECT "to_address_id" FROM "packages"
    WHERE "from_address_id" = (
        SELECT "id" FROM "addresses"
        WHERE "address" = '900 Somerville Avenue'
    ) AND "contents" = 'Congratulatory letter'
);

-- *** The Devious Delivery ***
SELECT "contents" FROM "packages"
WHERE "from_address_id" IS NULL;

SELECT * FROM "addresses"
WHERE "id" = (
    SELECT "address_id" FROM "scans"
    WHERE "package_id" = (
        SELECT "id" FROM "packages"
        WHERE "from_address_id" IS NULL
    )
    ORDER BY "timestamp" DESC
);

-- *** The Forgotten Gift ***
SELECT * FROM "packages"
WHERE "id" = (
    SELECT "package_id" FROM "scans"
    WHERE "address_id" = (
        SELECT "id" FROM "addresses"
        WHERE "address" = '109 Tileston Street'
    )
    AND "action" = 'Pick'
);

SELECT * FROM "drivers"
WHERE id = (
    SELECT "driver_id" FROM "scans"
    WHERE "package_id" = (
        SELECT "package_id" FROM "scans"
        WHERE "address_id" = (
            SELECT "id" FROM "addresses"
            WHERE "address" = '109 Tileston Street'
        )
    )
    ORDER BY "timestamp" DESC
);
