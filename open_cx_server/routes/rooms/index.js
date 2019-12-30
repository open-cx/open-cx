const rooms = require('express').Router();

const all = require('./all');
const single = require('./single');

rooms.get('/', all);
rooms.post('/', all);

rooms.get('/:postId', single);
rooms.delete('/:postId', single);

module.exports = rooms;
