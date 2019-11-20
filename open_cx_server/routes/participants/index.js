let Participant = require('../../models/participant');

const participants = require('express').Router();

const all = require('./all');
const single = require('./single');

participants.get('/', all);
participants.post('/', all);

participants.get('/:postId', single);
participants.post('/:postId', single);
participants.delete('/:postId', single);

module.exports = participants;
