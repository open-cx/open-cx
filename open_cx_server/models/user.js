const mongoose = require('mongoose');

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
  emitter: String,
  photo: String,
  location: String,
  description: String,
  tags: [String],
  skills: [String],
  socials: {
    facebook: String,
    instagram: String,
    github: String,
    linkedin: String,
    twitter: String,
    youtube: String,
  },
  programming_languages: [String],
  conferences: [String],
  points: {
    type: Number,
    min: 0
  },
  matches: [String]
});

module.exports = user = mongoose.model('User', userSchema);
