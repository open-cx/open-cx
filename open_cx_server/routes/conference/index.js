let Conference = require('../../models/conference');

const conferences = require('express').Router();

const all = require('./all');
const single = require('./single');

conferences.get('/', all);
conferences.post('/', all);

conferences.get('/:postId', single);
conferences.post('/:postId', single);

module.exports = conferences;
