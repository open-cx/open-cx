let POI = require('../../models/poi');

const singlePOI = require('express').Router();

singlePOI.get('/:postId', async (req, res) => {
  // res.send("Get request on /users/id");
  try {
    const poi = await POI.find({poiId: req.params.postId});
    res.json(poi);
  }
  catch (err) {
    res.json({ message: err });
  }

});

singlePOI.post('/:postId', async (req, res) => {
  // res.send(req.params);
  const poi = new POI({
    poiId: req.body.poiId,
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

module.exports = singlePOI;
