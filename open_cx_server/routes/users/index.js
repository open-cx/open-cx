const users = require('express').Router();

const all = require('./all');
const single = require('./single');

users.get('/', all);
users.post('/', all);

users.get('/:postId', single);
users.post('/:postId', single);


users.use('/tags', require('./tags'));

users.use('/matches', require('./matches'));
users.use('/description', require('./description'));
users.use('/socials', require('./socials'));
users.use('/profile', require('./profile'));
module.exports = users;