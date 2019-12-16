const talks = require('express').Router();

const all = require('./all');
const single = require('./single');

talks.get('/', all);
talks.post('/', all);

talks.get('/:postId', single);
talks.delete('/:postId', single);

module.exports = talks;
