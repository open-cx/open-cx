'use strict';

require('dotenv/config');

const bodyParser = require('body-parser');
const mongoose = require('mongoose');
const OPTS = { useUnifiedTopology: true, useNewUrlParser: true };
const express = require('express');
const app = express();
const cors = require('cors');
const PORT = 5000;
const HOST = '0.0.0.0';

const routes = require('./routes');

// Middlewares
app.use('/admin', require('./admin'))
app.use(bodyParser.json());


app.use('/', routes);
app.use(cors());

// Connects app to a MongoDB database
mongoose.connect(process.env.DB_CONNECTION, OPTS, () => { console.log("Attempting connection to database") });

app.listen(process.env.PORT || 5000);

console.log(`Running on http://${HOST}:${PORT}`);
