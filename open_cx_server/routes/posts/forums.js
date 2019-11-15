let Forum = require('../../models/forum');

const express = require('express');
const router = express.Router();

// Gets all of the forums
router.get('/', async (req, res) => {
  try {
    const forums = await Forum.find();
    res.json(forums);
  }
  catch (err) {
    res.json({ message: err })
  }
});

// Gets all of a specific Forum's info from the database
router.get('/:postId', async (req, res) => {
  try {
    const forum = await Forum.findById(req.params.postId);
    res.json(forum);
  }
  catch (err) {
    res.json({ message: err });
  }
})

// Delete Forum from database
router.delete('/:postId', async (req, res) => {
  try {
    const forum = await Forum.remove({ _id: req.params.postId });
    res.json(forum);
  }
  catch (err) {
    res.json({ message: err });
  }
});

// Adds a user to the database
router.post('/', async (req, res) => {
  const forum = new Forum({
    talk: req.body.talk,
    questions: req.body.questions,
    feedback: req.body.feedback,
    material: req.body.material,
  });

  try {
    const savedPost = await forum.save();
    res.json(savedPost);
  }
  catch (err) {
    res.json({ message: err });
  }

});

module.exports = router;
