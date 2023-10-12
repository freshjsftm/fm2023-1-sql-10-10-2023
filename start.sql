
DROP TABLE IF EXISTS "users";

CREATE TABLE IF NOT EXISTS "users"(
  "id" SERIAL PRIMARY KEY,
  "first_name" VARCHAR(32) NOT NULL CHECK("first_name"!=''),
  "last_name" VARCHAR(64) NOT NULL CHECK("last_name"!=''),
  "email" VARCHAR(256) NOT NULL CHECK("email"!='') UNIQUE,
  "is_male" BOOLEAN NOT NULL,
  "birthday" DATE NOT NULL CHECK("birthday"< current_date),
  "height" NUMERIC(3, 2) NOT NULL CHECK("height">1.3 AND "height"<2.7)
);

INSERT INTO "users" ("first_name","last_name","email","is_male","birthday","height")
VALUES 
('Brad','Pitt','pitt1@gmail.com', TRUE, '1963-12-18', 1.87),
('Alex','Pitt','pitt2@gmail.com', FALSE, '1963-12-18', 1.67),
('Tom','Bom','tom@gmail.com', TRUE, '1963-12-18', 1.87),
('Brad','Pitt','pitt4@gmail.com', TRUE, '1963-12-18', 1.83);

DROP TABLE IF EXISTS "messages";

CREATE TABLE IF NOT EXISTS "messages"(
  "id" BIGSERIAL PRIMARY KEY,
  "body" TEXT NOT NULL CHECK("body"!=''),
  "user_id" INT,
  "chat_id" INT,
  "created_at" TIMESTAMP NOT NULL DEFAULT current_timestamp,
  "is_read" BOOLEAN NOT NULL DEFAULT FALSE,
  FOREIGN KEY ("user_id", "chat_id") REFERENCES "users_to_chats"("user_id", "chat_id")
);

INSERT INTO "messages" ("user_id","chat_id", "body")
VALUES
(1, 1, 'hi!'), (2, 1, 'hi!'), (1, 1, ')))');



DROP TABLE IF EXISTS "orders";

CREATE TABLE "orders"(
  "id" BIGSERIAL PRIMARY KEY,
  "user_id" INT REFERENCES "users"("id"),
  "created_at" TIMESTAMP NOT NULL DEFAULT current_timestamp
);

INSERT INTO "orders" ("user_id")
VALUES (1),(1),(1),(1),(3);




DROP TABLE IF EXISTS "products";

CREATE TABLE IF NOT EXISTS "products"(
  "id" BIGSERIAL PRIMARY KEY,
  "name" VARCHAR(256) NOT NULL UNIQUE CHECK(length("name") BETWEEN 4 AND 256),
  "price" NUMERIC(7,2) NOT NULL CHECK("price" >0 AND "price"<=10000),
  "currency" VARCHAR(3) NOT NULL CHECK(length("currency") BETWEEN 2 AND 3) DEFAULT 'grn',
  "date_production" TIMESTAMP NOT NULL DEFAULT current_timestamp,
  "amount" SMALLINT NOT NULL CHECK("amount">0 AND "amount"<=1000)
);

INSERT INTO "products"("name","price","amount")
VALUES 
('apple',12.20,100),
('eggs',5.20,200),
('milk',36.00,200),
('teas',77.20,10);


CREATE TABLE IF NOT EXISTS "products_to_orders"(
  "product_id" BIGINT REFERENCES "products"("id"),
  "order_id" BIGINT REFERENCES "orders"("id"),
  "quantity" INT NOT NULL CHECK("quantity">0 AND "quantity"<=1000),
  PRIMARY KEY ("product_id", "order_id")
);

INSERT INTO "products_to_orders"
VALUES
(4,1,10),
(3,1,7),
(5,1,10),
(3,3,7),
(4,3,10),
(3,4,7),
(4,2,10);


CREATE TABLE "chats"(
  "id" SERIAL PRIMARY KEY,
  "title" VARCHAR(64) NOT NULL CHECK("title"!=''),
  "owner_id" INT REFERENCES "users"("id"),
  "created_at" TIMESTAMP NOT NULL DEFAULT current_timestamp
);

INSERT INTO "chats"("title", "owner_id")
VALUES ('js',1),('react',2),('html',3);

/*
посилання на юзера та чат
складений первинний ключ
*/
CREATE TABLE IF NOT EXISTS "users_to_chats"(
  "user_id" INT REFERENCES "users"("id"),
  "chat_id" INT REFERENCES "chats"("id"),
  PRIMARY KEY ("user_id", "chat_id")
);

INSERT INTO "users_to_chats" VALUES (2,1),(1,1),(2,2),(4,2);