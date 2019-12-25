const forums = require('express').Router();

const all = require('./all');
const single = require('./single');

forums.get('/', all);
forums.post('/', all);

forums.get('/:postId', single);
forums.post('/:postId', single);
forums.delete('/:postId', single);

module.exports = forums;
