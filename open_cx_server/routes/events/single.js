let Event = require('../../models/event');


const singleEvent = require('express').Router();

singleEvent.get('/:postId', async (req, res) => {
  try {
    const event = await Event.findById(req.params.postId);
    res.json(event);
  }
  catch (err) {
    res.json({ message: err });
  }
});

singleEvent.post('/:postId', async (req, res) => {
  res.send(req.params);
});

module.exports = singleEvent;
