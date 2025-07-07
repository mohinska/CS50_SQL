CREATE TABLE "ingredients" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "price_per_unit" NUMERIC NOT NULL,
    PRIMARY KEY("id")
);

CREATE TABLE "donuts" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "gluten_free" TEXT NOT NULL CHECK("gluten_free" IN ('yes', 'no')),
    "price_per_donut" NUMERIC NOT NULL,
    PRIMARY KEY("id")
);

CREATE TABLE "donut_ingredients" (
    "id" INTEGER,
    "donut_id" INTEGER,
    "ingredient_id" INTEGER,
    PRIMARY KEY("id"),
    FOREIGN KEY("donut_id") REFERENCES "donuts"("id"),
    FOREIGN KEY("ingredient_id") REFERENCES "ingredients"("id")
);

CREATE TABLE "customers" (
    "id" INTEGER,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    PRIMARY KEY("id")
);

CREATE TABLE "orders" (
    "id" INTEGER,
    "customer_id" INTEGER,
    PRIMARY KEY("id"),
    FOREIGN KEY("customer_id") REFERENCES "customers"("id")
);

CREATE TABLE "donuts_ordered" (
    "id" INTEGER,
    "order_id" INTEGER,
    "donut_id" INTEGER,
    PRIMARY KEY("id"),
    FOREIGN KEY("donut_id") REFERENCES "donuts"("id"),
    FOREIGN KEY("order_id") REFERENCES "orders"("id")
);
