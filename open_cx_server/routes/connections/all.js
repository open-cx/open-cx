let Connection = require('../../models/connection');

const allConnections = require('express').Router();

allConnections.get('/', async (req, res) => {
  try {
    const connections = await Connection.find();
    res.json(connections);
  }
  catch (err) {
    res.json({ message: err })
  }
});

allConnections.post('/', async (req, res) => {
  const connection = new Connection({
    connectionId: req.body.connectionId,
    connections: req.body.connections
  });

  try {
    const savedPost = await connection.save();
    res.json(savedPost);
  }
  catch (err) {
    res.json({ message: err });
  }

});

module.exports = allConnections;