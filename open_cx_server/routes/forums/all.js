let Forum = require('../../models/forum');

const allForums = require('express').Router();

allForums.get('/', async (req, res) => {
  try {
    const forums = await Forum.find();
    res.json(forums);
  }
  catch (err) {
    res.json({ message: err })
  }
});

allForums.post('/', async (req, res) => {
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

module.exports = allForums;