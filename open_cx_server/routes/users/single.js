let User = require('../../models/user');

const singleUser = require('express').Router();

singleUser.get('/:postId', async (req, res) => {
//   res.send("Get request on /users/id");
  try {
    const user = await User.findById(req.params.postId);
    res.json(user);
  }
  catch (err) {
    res.json({ message: err });
  }

});

singleUser.get('/:userId/matches', async (req, res) => {

  try {
    //Gets all the tags of the specified user
    const user = await User.findById(req.params.userId);
    var userTags = user['tags'];
    var tagsJson = {}
    var k=0;

    //Generates json object with Users that selected each of the tags
    for (i=0; i < userTags.length; i++) {

      const usersWithTag = await User.find({ $and: [ {tags: userTags[i]}, { _id: { $ne: req.params.userId}} ] });

      
      if (usersWithTag.length) {

        for (j=0; j < usersWithTag.length; j++) {
          // console.log(usersWithTag[j]["username"]);
          tagsJson[usersWithTag[j]["username"]] = usersWithTag[j];
          k++;
        }

      }
  }
  
    //Sends response
    res.json(tagsJson);
  }

  catch (err) {
    res.json({ message: err });
  }

});

singleUser.delete('/:postId', async (req, res) => {
//   res.send(req.params);

try {
    const removedPost = await User.remove({ _id: req.params.postId });
    res.json(removedPost);
  }
  catch (err) {
    res.json({ message: err });
  }

});


singleUser.post('/:postId', async (req, res) => {
//   res.send(req.params);

    const user = new User({
        username: req.body.username,
        password: req.body.password,
        age: req.body.age,
        birthPlace: req.body.birthPlace,
        description: req.body.description,
        tags: req.body.tags,
        conferences: req.body.conferences,
        points: req.body.points,
        matches: req.body.matches,
        eventsAttended: req.body.eventsAttended
    });

    try {
        const savedPost = await user.save();
        res.json(savedPost);
    }
    catch (err) {
        res.json({ message: err });
    }

});

module.exports = singleUser;
