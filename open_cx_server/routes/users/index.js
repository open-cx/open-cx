const users = require('express').Router();

const all = require('./all');
const single = require('./single');

users.get('/', all);
users.post('/', all);

users.get('/:postId', single);
users.post('/:postId', single);

module.exports = users;