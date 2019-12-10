let POI = require('../../models/poi');

const pois = require('express').Router();

const all = require('./all');
const single = require('./single');

pois.get('/', all);
pois.post('/', all);

pois.get('/:postId', single);
pois.post('/:postId', single);

module.exports = pois;
