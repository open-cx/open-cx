let Question = require('../../models/question');

const express = require('express');
const router = express.Router();

// Gets all of the questions
router.get('/', async (req, res) => {
  try {
    const questions = await Question.find();
    res.json(questions);
  }
  catch (err) {
    res.json({ message: err })
  }
});

// Gets all of a specific Question's info from the database
router.get('/:postId', async (req, res) => {
  try {
    const question = await Question.findById(req.params.postId);
    res.json(question);
  }
  catch (err) {
    res.json({ message: err });
  }
})

// Delete Question from database
router.delete('/:postId', async (req, res) => {
  try {
    const question = await Question.remove({ _id: req.params.postId });
    res.json(question);
  }
  catch (err) {
    res.json({ message: err });
  }
});

// Adds a user to the database
router.post('/', async (req, res) => {
  const question = new Question({
    content: req.body.content,
    answers: req.body.answers,
  });

  try {
    const savedPost = await question.save();
    res.json(savedPost);
  }
  catch (err) {
    res.json({ message: err });
  }

});

module.exports = router;
