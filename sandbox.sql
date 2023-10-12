DROP TABLE test;
CREATE TABLE test (
  student INT REFERENCES "students"("id"),
  -- 1 Tom    3-Alex
  predmet INT REFERENCES "predmets"("id"),
  -- 1 JS   2 SQL
  CONSTRAINT "test_key" PRIMARY KEY (student, predmet) 
);
INSERT INTO test
VALUES (1, 1),
  (1, 1),
  (3, 1),
  (1, 2);