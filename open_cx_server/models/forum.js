const mongoose = require('mongoose');

const forumSchema = mongoose.Schema({
  talk: {
    type: String,
    required: true
  },
  questions: {
    type: [String]
  },
  feedback: {
    type: [String]
  },
  material: {
    type: [String]
  }
});

module.exports = forum = mongoose.model('Forum', forumSchema);
