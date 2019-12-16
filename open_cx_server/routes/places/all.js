let Place = require('../../models/place');

const allPlaces = require('express').Router();

allPlaces.get('/', async (req, res) => {
  try {
    const places = await Place.find();
    res.json(places);
  }
  catch (err) {
    res.json({ message: err })
  }
});

allPlaces.post('/', async (req, res) => {
  res.send("Post on all places");
});

module.exports = allPLaces;