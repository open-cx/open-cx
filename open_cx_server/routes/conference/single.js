let Conference = require('../../models/conference');

const singleConference = require('express').Router();

singleConference.get('/:postId', async (req, res) => {

  try {
    const conference = await Conference.findById(req.params.postId);
    res.json(conference);
  }
  catch (err) {
    res.json({ message: err });
  }

});

singleConference.post('/:postId', async (req, res) => {
  res.send(req.params);
});

module.exports = singleConference;
