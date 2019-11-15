const mongoose = require('mongoose');

const talkSchema = mongoose.Schema({
  date: {
    type: Date,
    required: true
  },
  initial_time: {
    type: Date,
    required: true
  },
  final_time: {
    type: Date,
    required: true
  },
  description: {
    type: [String]
  }
});

module.exports = talk = mongoose.model('Talk', talkSchema);
