const events = require('express').Router();

const all = require('./all');
const single = require('./single');

events.get('/', all);
events.post('/', all);

events.get('/:postId', single);
events.post('/:postId', single);

module.exports = events;
