const { Client } = require('pg');

const config = {
  host: 'localhost',
  port: 5432,
  database: 'fm2023-1-db1',
  user: 'postgres',
  password: 'postgres',
};

const client = new Client(config);
start();

async function start() {
  try {
    await client.connect();
    const res = await client.query(`
    CREATE TABLE "from_node"(
      "id" SERIAL PRIMARY KEY
      );
  `);
    console.log(res);
    await client.end();
  } catch (error) {
    console.log(error);
  }
}
