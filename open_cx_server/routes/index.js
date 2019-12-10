const routes = require('express').Router();

const users = require('./users');
const events = require('./events');
const forums = require('./forums');
const participants = require('./participants');
const questions = require('./questions');
const speakers = require('./speakers');
const talks = require('./talks');
const pois = require('./pois');

routes.get('/', (req, res) => {
  res.status(200).json({ message: 'Bem vindos ao root directory do servidor do projeto open-cx!\nPara informações relativas à utilização da API e da base de dados, por favor consultem a documentação fornecida no repositório do open-cx.\n\n' });
});

routes.use('/users', users);
routes.use('/events', events);
routes.use('/forums', forums);
routes.use('/participants', participants);
routes.use('/questions', questions);
routes.use('/speakers', speakers);
routes.use('/talks', talks);
routes.use('/pois', pois);

module.exports = routes;
