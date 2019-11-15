const mongoose = require('mongoose');

const questionSchema = mongoose.Schema({
  content: {
    type: String,
    required: true
  },
  answers: {
    type: [String]
  }
});

module.exports = question = mongoose.model('Question', questionSchema);
