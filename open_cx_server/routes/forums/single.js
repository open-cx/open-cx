let Forum = require('../../models/forum');

const singleForum = require('express').Router();

// Gets all of a specific Forum's info from the database
singleForum.get('/:postId', async (req, res) => {
    try {
      const forum = await Forum.findById(req.params.postId);
      res.json(forum);
    }
    catch (err) {
      res.json({ message: err });
    }
})


singleForum.delete('/:postId', async (req, res) => {
    try {
      const forum = await Forum.remove({ _id: req.params.postId });
      res.json(forum);
    }
    catch (err) {
      res.json({ message: err });
    }
});


singleForum.post('/:postId', async (req, res) => {
  res.send(req.params);
});

module.exports = singleForum;
