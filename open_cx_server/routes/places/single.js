let Place = require('../../models/place');

const singlePlace = require('express').Router();

singlePlace.get('/:postId', async (req, res) => {
//   res.send("Get request on /users/id");
  try {
    const place = await Place.findById(req.params.postId);
    res.json(place);
  }
  catch (err) {
    res.json({ message: err });
  }

});

singlePlace.post('/:postId', async (req, res) => {
//   res.send(req.params);

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

module.exports = singlePlace;
