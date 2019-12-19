let Talk = require('../../models/talk');

const allTalks = require('express').Router();

allTalks.get('/', async (req, res) => {
    try {
      const talks = await Talk.find();
      res.json(talks);
    }
    catch (err) {
      res.json({ message: err })
    }
  });

  allTalks.post('/', async (req, res) => {
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
  

module.exports = allTalks;