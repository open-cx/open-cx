const User = require("../../models/user");
const verify = require("../auth/verifyToken");
const singleUser = require("express").Router();
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const { registerValidation, loginValidation } = require("../../validation");

/**
 * Logs a user in by sending back the user's corresponding JWT
 */
singleUser.post("/login", async (req, res) => {
  // Validate the data
  const { error } = loginValidation(req.body);
  if (error) return res.status(400).send(error.details[0].message);

  // Check if email exists
  const user = await User.findOne({
    email: req.body.email
  });
  if (!user) return res.status(400).send("Invalid email");

  // Password is correct
  const validPassword = await bcrypt.compare(req.body.password, user.password);
  if (!validPassword) return res.status(400).send("Invalid password");

  // Create and assign a JSON web token
  const token = jwt.sign(
    {
      _id: user._id
    },
    process.env.TOKEN_SECRET
  );

  res.header("auth-token", token);
  res.send("User logged in successfully.");
});

/**
 * Registers a new user.
 * Checks if the email is already in use. If not, creates a new user and
 * inserts it into the database.
 * Generates and returns the user's id.
 */

singleUser.post("/register", async (req, res) => {
  // Validate the data
  const { error } = registerValidation(req.body);
  if (error) return res.status(400).send(error.details[0].message);

  // Check if user is already in the database
  const emailExists = await User.findOne({
    email: req.body.email
  });
  if (emailExists) return res.status(400).send("Email already exists");

  // Hash passwords
  const salt = await bcrypt.genSalt(10);
  const hashedPassword = await bcrypt.hash(req.body.password, salt);

  // Create new user
  const user = new User({
    fullname: req.body.fullname,
    email: req.body.email,
    password: hashedPassword
  });

  try {
    const savedPost = await user.save();
    res.send("User registred successfully");
  } catch (err) {
    res.status(400).send(err);
  }
});

singleUser.get("/:email", verify, async (req, res) => {
  try {
    const user = await User.findOne({ email: req.params.email });
    res.json(user);
  } catch (err) {
    res.json({ message: err });
  }
});

singleUser.delete("/:email", verify, async (req, res) => {
  try {
    const removedPost = await User.remove({ _id: req.params.email });
    res.json(removedPost);
  } catch (err) {
    res.json({ message: err });
  }
});

module.exports = singleUser;
