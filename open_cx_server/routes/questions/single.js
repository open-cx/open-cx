let Question = require('../../models/question');

const singleQuestion = require('express').Router();

singleQuestion.get('/:postId', async (req, res) => {
  try {
    const question = await Question.findById(req.params.postId);
    res.json(question);
  }
  catch (err) {
    res.json({ message: err });
  }
})

singleQuestion.post('/:postId', async (req, res) => {
  res.send(req.params);
});

singleQuestion.delete('/:postId', async (req, res) => {
  try {
    const question = await Question.remove({ _id: req.params.postId });
    res.json(question);
  }
  catch (err) {
    res.json({ message: err });
  }
});

module.exports = singleQuestion;
