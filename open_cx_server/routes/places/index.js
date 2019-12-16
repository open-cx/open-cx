const places = require('express').Router();

const all = require('./all');
const single = require('./single');

places.get('/', all);
places.post('/', all);

places.get('/:postId', single);
places.post('/:postId', single);

module.exports = places;
