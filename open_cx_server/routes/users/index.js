let User = require('../../models/user');

const users = require('express').Router();

const all = require('./all');
const single = require('./single');

users.get('/', all);
users.post('/', all);

users.get('/:postId', single);
users.post('/:postId', single);
users.get('/:userId/matches', single);

module.exports = users;