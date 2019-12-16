const singlePlace = require('express').Router();

singlePlace.get('/:postId', async (req, res) => {
  res.send("Get request on /places/id");
});

singlePlace.post('/:postId', async (req, res) => {
  res.send(req.params);
});

module.exports = singlePlace;
