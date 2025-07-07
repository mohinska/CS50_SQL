CREATE TABLE "meteorites_temp" (
    "name" TEXT NOT NULL,
    "id" INTEGER NOT NULL,
    "nametype" TEXT NOT NULL,
    "class" TEXT NOT NULL,
    "mass" NUMERIC,
    "discovery" TEXT,
    "year" INTEGER,
    "lat" NUMERIC,
    "long" NUMERIC,
    PRIMARY KEY("id")
);

.import --csv --skip 1 meteorites.csv meteorites_temp

UPDATE "meteorites_temp"
SET "mass" = NULL
WHERE "mass" = '';

UPDATE "meteorites_temp"
SET "year" = NULL
WHERE "year" = '';

UPDATE "meteorites_temp"
SET "lat" = NULL
WHERE "lat" = '';

UPDATE "meteorites_temp"
SET "long" = NULL
WHERE "long" = '';

UPDATE "meteorites_temp"
SET "mass" = ROUND("mass", 2);

UPDATE "meteorites_temp"
SET "long" = ROUND("long", 2);

UPDATE "meteorites_temp"
SET "lat" = ROUND("lat", 2);

CREATE TABLE "meteorites" (
    "id" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "class" TEXT NOT NULL,
    "mass" NUMERIC,
    "discovery" TEXT,
    "year" INTEGER,
    "lat" NUMERIC,
    "long" NUMERIC,
    PRIMARY KEY("id")
);

INSERT INTO "meteorites" ("name", "class", "mass", "discovery", "year", "lat", "long")
SELECT "name", "class", "mass", "discovery", "year", "lat", "long" FROM "meteorites_temp"
WHERE "nametype" != 'Relict'
ORDER BY "year", "name";

DROP TABLE "meteorites_temp";
