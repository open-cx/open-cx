const auth = require('express').Router();

const register = require('./register');

auth.post('/register', register);

module.exports = auth;
