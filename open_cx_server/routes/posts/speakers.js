let Speaker = require('../../models/speaker');

const express = require('express');
const router = express.Router();

// Gets all of the speakers
router.get('/', async (req, res) => {
  try {
    const speakers = await Speaker.find();
    res.json(speakers);
  }
  catch (err) {
    res.json({ message: err })
  }
});

// Gets all of a specific Speaker's info from the database
router.get('/:postId', async (req, res) => {
  try {
    const speaker = await Speaker.findById(req.params.postId);
    res.json(speaker);
  }
  catch (err) {
    res.json({ message: err });
  }
})

// Delete Forum from database
router.delete('/:postId', async (req, res) => {
  try {
    const speaker = await Speaker.remove({ _id: req.params.postId });
    res.json(speaker);
  }
  catch (err) {
    res.json({ message: err });
  }
});

// Adds a user to the database
router.post('/', async (req, res) => {
  const speaker = new Speaker({
    username: req.body.username,
    talks: req.body.talks,
  });

  try {
    const savedPost = await speaker.save();
    res.json(savedPost);
  }
  catch (err) {
    res.json({ message: err });
  }

});

module.exports = router;
