const singleEvent = require('express').Router();

singleEvent.get('/:postId', async (req, res) => {
  res.send("Get request on /events/id");
});

singleEvent.post('/:postId', async (req, res) => {
  res.send(req.params);
});

module.exports = singleEvent;
