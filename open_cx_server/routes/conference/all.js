let Conference = require('../../models/conference');

const allConferences = require('express').Router();

allConferences.get('/', async (req, res) => {
  try {
    const conference = await Conference.find();
    res.json(conference);
  }
  catch (err) {
    res.json({ message: err })
  }
});

allConferences.post('/', async (req, res) => {
  res.send("Post on all conferences");
});

module.exports = allConferences;