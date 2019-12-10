let POI = require('../../models/poi');

const allPOIs = require('express').Router();

allPOIs.get('/', async (req, res) => {
  try {
    const pois = await POI.find();
    res.json(pois);
  }
  catch (err) {
    res.json({ message: err })
  }
});

allPOIs.post('/', async (req, res) => {
  const poi = new POI({
    latitude: req.body.latitude,
    longitude: req.body.longitude,
    floor: req.body.floor,
  });

  try {
    const savedPost = await poi.save();
    res.json(savedPost);
  }
  catch (err) {
    res.json({ message: err });
  }

});

module.exports = allPOIs;