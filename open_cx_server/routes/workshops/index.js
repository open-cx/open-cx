const workshops = require('express').Router();

const all = require('./all');
const single = require('./single');

workshops.get('/', all);
workshops.post('/', all);

workshops.get('/:postId', single);
workshops.delete('/:postId', single);

module.exports = workshops;
