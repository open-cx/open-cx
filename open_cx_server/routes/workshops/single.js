let Workshop = require('../../models/workshop');

const singleWorkshop = require('express').Router();

singleWorkshop.get('/:postId', async (req, res) => {
    try {
      const workshop = await Workshop.findById(req.params.postId);
      res.json(workshop);
    }
    catch (err) {
      res.json({ message: err });
    }
  })

singleWorkshop.delete('/:postId', async (req, res) => {
    try {
      const workshop = await Workshop.remove({ _id: req.params.postId });
      res.json(workshop);
    }
    catch (err) {
      res.json({ message: err });
    }
});


module.exports = singleWorkshop;
