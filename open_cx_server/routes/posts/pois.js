let POI = require('../../models/poi');
let POIType = require('../../models/poi_type');

const express = require('express');
const router = express.Router();

// Gets all of the points of interest
router.get('/', async (req, res) => {
  try {
    const pointsOfInterest = await POI.find();
    res.json(pointsOfInterest);
  }
  catch (err) {
    res.json({ message: err })
  }
});

// Gets info about a specific POI from the database
router.get('/:postId', async (req, res) => {
  try {
    const pointOfInterest = await POI.findById(req.params.postId);
    res.json(pointOfInterest);
  }
  catch (err) {
    res.json({ message: err });
  }
})

// Delete POI from database
router.delete('/:postId', async (req, res) => {
  try {
    const pointOfInterest = await POI.remove({ _id: req.params.postId });
    res.json(pointOfInterest);
  }
  catch (err) {
    res.json({ message: err });
  }
});

// Adds a POI to the database
router.post('/', async (req, res) => {
  const pointOfInterest = new POI({
    POI: req.body.POI,
  });

  try {
    const savedPost = await pointOfInterest.save();
    res.json(savedPost);
  }
  catch (err) {
    res.json({ message: err });
  }

});

module.exports = router;
