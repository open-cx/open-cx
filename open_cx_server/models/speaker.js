const mongoose = require('mongoose');

const speakerSchema = mongoose.Schema({
  username: {
    type: String,
    required: true
  },
  talks: {
    type: [String],
    required: true
  }
});

module.exports = speaker = mongoose.model('Speaker', speakerSchema);
