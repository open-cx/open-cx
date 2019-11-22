let Participant = require('../../models/participant');

const allParticipants = require('express').Router();

allParticipants.get('/', async (req, res) => {
  try {
    const participants = await Participant.find();
    res.json(participants);
  }
  catch (err) {
    res.json({ message: err })
  }
});

allParticipants.post('/', async (req, res) => {
  const participant = new Participant({
    participant: req.body.participant,
  });

  try {
    const savedPost = await participant.save();
    res.json(savedPost);
  }
  catch (err) {
    res.json({ message: err });
  }

});


module.exports = allParticipants;