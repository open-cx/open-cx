'use strict';

require('dotenv/config');

const bodyParser = require('body-parser');
const mongoose = require('mongoose');
const OPTS = { useUnifiedTopology: true, useNewUrlParser: true };
const express = require('express');
const app = express();
const usersRoute = require('./routes/posts/users');
const eventsRoute = require('./routes/posts/events');
const forumsRoute = require('./routes/posts/forums');
const participantsRoute = require('./routes/posts/participants');
const questionsRoute = require('./routes/posts/questions');
const speakersRoute = require('./routes/posts/speakers');
const talksRoute = require('./routes/posts/talks');
const cors = require('cors');
const PORT = 2222;
const HOST = '0.0.0.0';


// Connects app to a MongoDB database
mongoose.connect("localhost:27017", { useNewUrlParser: true,
  useCreateIndex: true }).then(startExpress);

function startExpress() {
// Middlewares
app.use('/admin', require('./admin'))
app.use(bodyParser.json());
app.use('/posts/users', usersRoute);
app.use('/posts/events', eventsRoute);
app.use('/posts/forums', forumsRoute);
app.use('/posts/participant', participantsRoute);
app.use('/posts/question', questionsRoute);
app.use('/posts/speaker', speakersRoute);
app.use('/posts/talk', talksRoute);
app.use(cors());

// Get request
app.get('/', (req, res) => {
  res.send("Root directory\n");
});

app.listen(PORT, HOST);
console.log(`Running on http://${HOST}:${PORT}`);

}

