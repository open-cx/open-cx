let User = require('../../models/user');

const allUsers = require('express').Router();

allUsers.get('/', async (req, res) => {
  try {
    const users = await User.find().select('email');
    res.json(users);
  }
  catch (err) {
    res.json({ message: err })
  }
});

module.exports = allUsers;
