let Speaker = require('../../models/speaker');

const allSpeakers = require('express').Router();

allSpeakers.get('/', async (req, res) => {
    try {
      const speakers = await Speaker.find();
      res.json(speakers);
    }
    catch (err) {
      res.json({ message: err })
    }
  });

allSpeakers.post('/', async (req, res) => {
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

module.exports = allSpeakers;