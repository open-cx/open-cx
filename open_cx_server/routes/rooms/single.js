let Room = require('../../models/room');

const singleRoom = require('express').Router();

singleRoom.get('/:postId', async (req, res) => {
    try {
      const room = await Room.findById(req.params.postId);
      res.json(room);
    }
    catch (err) {
      res.json({ message: err });
    }
  })

  singleRoom.delete('/:postId', async (req, res) => {
    try {
      const room = await Room.remove({ _id: req.params.postId });
      res.json(room);
    }
    catch (err) {
      res.json({ message: err });
    }
  });


module.exports = singleRoom;
