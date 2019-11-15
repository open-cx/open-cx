let Participant = require('../../models/participant');

const express = require('express');
const router = express.Router();

// Gets all of the participants
router.get('/', async (req, res) => {
  try {
    const participants = await Participant.find();
    res.json(participants);
  }
  catch (err) {
    res.json({ message: err })
  }
});

// Gets all of a specific Participant's info from the database
router.get('/:postId', async (req, res) => {
  try {
    const participant = await Participant.findById(req.params.postId);
    res.json(participant);
  }
  catch (err) {
    res.json({ message: err });
  }
})

// Delete Participant from database
router.delete('/:postId', async (req, res) => {
  try {
    const participant = await Participant.remove({ _id: req.params.postId });
    res.json(participant);
  }
  catch (err) {
    res.json({ message: err });
  }
});

// Adds a Participant to the database
router.post('/', async (req, res) => {
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

module.exports = router;
