let POIType = require('../../models/poi_type');

const express = require('express');
const router = express.Router();

// Gets all of the poi types
router.get('/', async (req, res) => {
  try {
    const poiTypes = await POIType.find();
    res.json(poiTypes);
  }
  catch (err) {
    res.json({ message: err })
  }
});

// Gets info about a specific POI type from the database
router.get('/:postId', async (req, res) => {
  try {
    const poiType = await POIType.findById(req.params.postId);
    res.json(poiType);
  }
  catch (err) {
    res.json({ message: err });
  }
})

// Delete POI type from database
router.delete('/:postId', async (req, res) => {
  try {
    const poiType = await POIType.remove({ _id: req.params.postId });
    res.json(poiType);
  }
  catch (err) {
    res.json({ message: err });
  }
});

// Adds a POI type to the database
router.post('/', async (req, res) => {
  const poiType = new POIType({
    POIType: req.body.POIType,
  });

  try {
    const savedPost = await poiType.save();
    res.json(savedPost);
  }
  catch (err) {
    res.json({ message: err });
  }

});

module.exports = router;
