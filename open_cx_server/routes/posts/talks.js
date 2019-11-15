let Talk = require('../../models/talk');

const express = require('express');
const router = express.Router();

// Gets all of the talks
router.get('/', async (req, res) => {
  try {
    const talks = await Talk.find();
    res.json(talks);
  }
  catch (err) {
    res.json({ message: err })
  }
});

// Gets all of a specific Talk's info from the database
router.get('/:postId', async (req, res) => {
  try {
    const talk = await Talk.findById(req.params.postId);
    res.json(talk);
  }
  catch (err) {
    res.json({ message: err });
  }
})

// Delete Talk from database
router.delete('/:postId', async (req, res) => {
  try {
    const talk = await Talk.remove({ _id: req.params.postId });
    res.json(talk);
  }
  catch (err) {
    res.json({ message: err });
  }
});

// Adds a user to the database
router.post('/', async (req, res) => {
  const talk = new Talk({
    date: req.body.date,
    initial_time: req.body.initial_time,
    final_time: req.body.final_time,
    description: req.body.description
  });

  try {
    const savedPost = await talk.save();
    res.json(savedPost);
  }
  catch (err) {
    res.json({ message: err });
  }

});

module.exports = router;
