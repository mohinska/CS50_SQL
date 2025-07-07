CREATE TABLE "passengers" (
    "id" INTEGER,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "age" INTEGER CHECK("age" > 0),
    PRIMARY KEY("id")
);

CREATE TABLE "airlines" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "concourse" TEXT NOT NULL CHECK("concourse" IN ('A', 'B', 'C', 'D', 'F', 'E', 'T')),
    PRIMARY KEY("id")
);

CREATE TABLE "flights" (
    "id" INTEGER,
    "number" INTEGER NOT NULL,
    "airline_id" INTEGER,
    "from_airport_code" TEXT NOT NULL,
    "to_airport_code" TEXT NOT NULL,
    "departure_time" NUMERIC NOT NULL CHECK("departure_time" < "arrival_time"),
    "arrival_time" NUMERIC NOT NULL CHECK("departure_time" < "arrival_time"),
    PRIMARY KEY("id"),
    FOREIGN KEY("airline_id") REFERENCES "airlines"("id")
);

CREATE TABLE "checkins" (
    "id" INTEGER,
    "passenger_id" INTEGER,
    "flight_id" INTEGER,
    "time" NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY("id")
    FOREIGN KEY("passenger_id") REFERENCES "passengers"("id")
    FOREIGN KEY("flight_id") REFERENCES "flights"("id")
);
