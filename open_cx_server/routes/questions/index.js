let Question = require('../../models/question');

const questions = require('express').Router();

const all = require('./all');
const single = require('./single');

questions.get('/', all);
questions.post('/', all);

questions.get('/:postId', single);
questions.post('/:postId', single);
questions.delete('/:postId', single);

module.exports = questions;
