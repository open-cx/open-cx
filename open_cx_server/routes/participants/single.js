let Participant = require('../../models/participant');

const singleParticipant = require('express').Router();

singleParticipant.get('/:postId', async (req, res) => {
    try {
      const participant = await Participant.findById(req.params.postId);
      res.json(participant);
    }
    catch (err) {
      res.json({ message: err });
    }
})


singleParticipant.delete('/:postId', async (req, res) => {
    try {
      const participant = await Participant.remove({ _id: req.params.postId });
      res.json(participant);
    }
    catch (err) {
      res.json({ message: err });
    }
});
  

singleParticipant.post('/:postId', async (req, res) => {
  res.send(req.params);
});

module.exports = singleParticipant;
