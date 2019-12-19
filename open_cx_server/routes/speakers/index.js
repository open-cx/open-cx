let Speaker = require('../../models/speaker');

const speakers = require('express').Router();

const all = require('./all');
const single = require('./single');

speakers.get('/', all);
speakers.post('/', all);

speakers.get('/:postId', single);
speakers.post('/:postId', single);
speakers.delete('/:postId', single);

module.exports = speakers;
