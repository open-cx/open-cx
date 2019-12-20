const rooms = require('express').Router();

const single = require('./single');

rooms.get('/:postId', single);
rooms.delete('/:postId', single);

module.exports = rooms;
