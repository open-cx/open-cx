const mongoose = require("mongoose");

const userSchema = mongoose.Schema({
  username: {
    type: String
  },
  fullname: {
    type: String,
    required: true
  },
  password: {
    type: String,
    required: true
  },
  email: {
    type: String,
    required: true
  },
  age: {
    type: Number,
    min: 13,
    max: 90
  },
  description: String,
  tags: [String],
  conferences: [String],
  points: {
    type: Number,
    min: 0
  },
  matches: [String],
});

module.exports = user = mongoose.model("User", userSchema);
