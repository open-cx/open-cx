let Event = require('../../models/event');

const express = require('express');
const router = express.Router();

router.get('/', async (req, res) => {
  try {
    const users = await Event.find();
    res.json(users);
  }
  catch (err) {
    res.json({ message: err })
  }
});

module.exports = router;