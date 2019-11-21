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

singleUser.delete('/:postId', async (req, res) => {
  try{
    const removedUser = await User.deleteOne({_id: req.params.postId});

    Object.keys(res.body).forEach((key) => {
      const elems = removedUser[key];
      elems.pop(elems.indexOf(res.body[key]));
    })

    const user = new User(removedUser);

    const savedUser = await user.save();

    res.json(savedUser);

  }catch(err){
    res.statusCode = 500;
    res.json({message: err});
  }
});


singleUser.delete('/:postId', async (req, res) => {
  try{
    const removedUser = await User.deleteOne({_id: req.params.postId});

    Object.keys(res.body).forEach((key) => {
      const elems = removedUser[key];
      elems.push(res.body[key]);
    })

    const user = new User(removedUser);

    const savedUser = await user.save();

    res.json(savedUser);

  }catch(err){
    res.statusCode = 500;
    res.json({message: err});
  }
});

module.exports = singleUser;
