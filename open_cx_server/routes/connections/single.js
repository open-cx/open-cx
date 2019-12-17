let Connection = require('../../models/connection');

const singleConnection = require('express').Router();

singleConnection.get('/:postId', async (req, res) => {
//   res.send("Get request on /users/id");
  try {
    const connection = await Connection.find({connectionId: req.params.postId});
    res.json(connection);
  }
  catch (err) {
    res.json({ message: err });
  }

});

singleConnection.post('/:postId', async (req, res) => {
//   res.send(req.params);

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

module.exports = singleConnection;
