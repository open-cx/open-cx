let Event = require('../../models/event');

const allEvents = require('express').Router();

allEvents.get('/', async (req, res) => {
  try {
    const events = await Event.find();
    res.json(events);
  }
  catch (err) {
    res.json({ message: err })
  }
});

allEvents.post('/', async (req, res) => {
  res.send("Post on all events");
});

module.exports = allEvents;