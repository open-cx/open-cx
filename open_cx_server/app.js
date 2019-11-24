'use strict';

require('dotenv/config');

const bodyParser = require('body-parser');
const mongoose = require('mongoose');
const OPTS = { useUnifiedTopology: true, useNewUrlParser: true };
const express = require('express');
const app = express();
const cors = require('cors');
const PORT = 8000;
const HOST = 'localhost';

const routes = require('./routes');

// Middlewares
app.use('/admin', require('./admin'))
app.use(bodyParser.json());


app.use('/', routes);
app.use(cors());

// Connects app to a MongoDB database
mongoose.connect(process.env.DB_CONNECTION, OPTS, () => { console.log("Attempting connection to database") });

const server = app.listen(process.env.PORT || 5000);
const io = require('socket.io')(server);
const cache = require('./socket')(io);


app.set('cache', cache);
app.set('socketio', io);


console.log(`Running on http://${HOST}:${PORT}`);
