"use strict";

require("dotenv/config");
const verify = require("./routes/auth/verifyToken");

const mongoose = require("mongoose");
let OPTS = {
  useUnifiedTopology: true,
  useNewUrlParser: true,
  keepAlive: 300000,
  connectTimeoutMS: 30000,
  keepAlive: 300000,
  connectTimeoutMS: 30000
};
const express = require('express');
const app = express();
const cors = require("cors");
const PORT = process.env.PORT || 5000;
const HOST = process.env.HOST || "localhost";
const DB_CONNECTION =
  process.env.DB_CONNECTION || "mongodb://mongo:27017/testdb";
const routes = require("./routes");

// Middlewares
app.use('/admin', require('./admin'))
app.use(express.json());
app.use(express.urlencoded());

app.use('/', routes);
app.use(cors());

console.log("Attempting connection to database...");

// Connects app to a MongoDB database
if (process.env.DB_CONNECTION) {
  mongoose.connect(DB_CONNECTION, OPTS, () => {
    console.log("Established connection with database");
  });
} else {
  console.log("Could not establish connection with database");
  // Connect to local database
}

app.listen(PORT);

console.log(`Running on http://${HOST}:${PORT}`);
