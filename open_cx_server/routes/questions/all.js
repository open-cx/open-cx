let Question = require('../../models/question');

const allQuestions = require('express').Router();

allQuestions.get('/', async (req, res) => {
  try {
    const questions = await Question.find();
    res.json(questions);
  }
  catch (err) {
    res.json({ message: err })
  }
});

allQuestions.post('/', async (req, res) => {
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

module.exports = allQuestions;