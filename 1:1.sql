CREATE TABLE "coaches"(
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR(64)
  -- "team_id" INT REFERENCES "teames"("id")
);
CREATE TABLE "teames"(
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR(64),
  "coach_id" INT REFERENCES "coaches"("id")
);

ALTER TABLE "coaches"
ADD COLUMN "team_id" INT REFERENCES "teames"("id");