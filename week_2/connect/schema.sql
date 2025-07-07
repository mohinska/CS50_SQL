CREATE TABLE "users" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "username" TEXT NOT NULL UNIQUE,
    "password" TEXT NOT NULL,
    PRIMARY KEY("id")
);

CREATE TABLE "schools" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "type" TEXT NOT NULL CHECK("type" IN ('Elementary School', 'Middle School', 'High School', 'Lower School', 'Upper School', 'College', 'University')),
    "location" TEXT NOT NULL,
    "year" INTEGER NOT NULL CHECK("year" > 0),
    PRIMARY KEY("id")
);

CREATE TABLE "companies" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "type" TEXT NOT NULL CHECK("type" IN ('Education', 'Technology', 'Finance')),
    "location" TEXT NOT NULL,
    PRIMARY KEY("id")
);

CREATE TABLE "people_connections" (
    "userA_id" INTEGER,
    "userB_id" INTEGER,
    PRIMARY KEY("userA_id", "userB_id"),
    FOREIGN KEY("userA_id") REFERENCES "users"("id"),
    FOREIGN KEY("userB_id") REFERENCES "users"("id")
);

CREATE TABLE "school_connections" (
    "id" INTEGER,
    "user_id" INTEGER,
    "school_id" INTEGER,
    "affiliation_start" NUMERIC NOT NULL CHECK("affiliation_start" < "affiliation_end"),
    "affiliation_end" NUMERIC NOT NULL CHECK("affiliation_start" < "affiliation_end"),
    "degree_type" TEXT NOT NULL CHECK("degree_type" IN ('BA', 'MA', 'PhD')),
    PRIMARY KEY("id"),
    FOREIGN KEY("user_id") REFERENCES "users"("id"),
    FOREIGN KEY("school_id") REFERENCES "schools"("id")
);

CREATE TABLE "company_connections" (
    "id" INTEGER,
    "user_id" INTEGER,
    "company_id" INTEGER,
    "affiliation_start" NUMERIC NOT NULL CHECK("affiliation_start" < "affiliation_end"),
    "affiliation_end" NUMERIC CHECK("affiliation_start" < "affiliation_end"),
    "title" TEXT NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("user_id") REFERENCES "users"("id"),
    FOREIGN KEY("company_id") REFERENCES "companies"("id")
);
