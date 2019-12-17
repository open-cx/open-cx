let Workshop = require('../../models/workshop');

const allWorkshops = require('express').Router();

allWorkshops.get('/', async (req, res) => {
    try {
        const workshops = await Workshop.find();
        res.json(workshops);
    }
    catch (err) {
        res.json({ message: err })
    }
});

allWorkshops.post('/', async (req, res) => {
    const workshop = new Workshop({
        date: req.body.date,
        speaker: req.body.speaker,
        poiId: req.body.poiId,
        room: req.body.room,
        initial_time: req.body.initial_time,
        final_time: req.body.final_time,
        description: req.body.description,
        tags: req.body.tags,
    });
  
    try {
      const savedPost = await workshop.save();
      res.json(savedPost);
    }
    catch (err) {
      res.json({ message: err });
    }
  
  });
  

module.exports = allWorkshops;