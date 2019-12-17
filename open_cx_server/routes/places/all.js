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
  const place = new Place({
    poiId: req.body.poiId,
    room: req.body.room,
  });

  try {
    const savedPost = await place.save();
    res.json(savedPost);
  }
  catch (err) {
    res.json({ message: err });
  }

});

module.exports = allPlaces;
