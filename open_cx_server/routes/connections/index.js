let Connection = require('../../models/connection');

const connections = require('express').Router();

const all = require('./all');
const single = require('./single');

connections.get('/', all);
connections.post('/', all);

connections.get('/:postId', single);
connections.post('/:postId', single);

module.exports = connections;
