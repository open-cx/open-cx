let Talk = require('../../models/talk');

const singleTalk = require('express').Router();

singleTalk.get('/:postId', async (req, res) => {
    try {
      const talk = await Talk.findById(req.params.postId);
      res.json(talk);
    }
    catch (err) {
      res.json({ message: err });
    }
  })

  singleTalk.delete('/:postId', async (req, res) => {
    try {
      const talk = await Talk.remove({ _id: req.params.postId });
      res.json(talk);
    }
    catch (err) {
      res.json({ message: err });
    }
  });


module.exports = singleTalk;
