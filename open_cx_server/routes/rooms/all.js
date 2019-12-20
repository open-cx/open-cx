let Room = require('../../models/room');

const allRooms = require('express').Router();

allRooms.get('/', async (req, res) => {
    try {
      const rooms = await Room.find();
      res.json(rooms);
    }
    catch (err) {
      res.json({ message: err })
    }
  });

  allRooms.post('/', async (req, res) => {
    const room = new Room({
      name: req.body.name,
      occupation: req.body.occupation
    });
  
    try {
      const savedPost = await room.save();
      res.json(savedPost);
    }
    catch (err) {
      res.json({ message: err });
    }
  
  });
  

module.exports = allRooms;