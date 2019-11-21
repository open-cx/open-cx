let Speaker = require('../../models/speaker');

const singleSpeaker = require('express').Router();

singleSpeaker.get('/:postId', async (req, res) => {
    try {
      const speaker = await Speaker.findById(req.params.postId);
      res.json(speaker);
    }
    catch (err) {
      res.json({ message: err });
    }
  });

  singleSpeaker.delete('/:postId', async (req, res) => {
    try {
      const speaker = await Speaker.remove({ _id: req.params.postId });
      res.json(speaker);
    }
    catch (err) {
      res.json({ message: err });
    }
  });
  

singleSpeaker.post('/:postId', async (req, res) => {
  res.send(req.params);
});

module.exports = singleSpeaker;
