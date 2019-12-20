const mongoose = require('mongoose');

const roomSchema = mongoose.Schema({
  name: {
    type: String,
    required: true
  },
  occupation: {
    type: Number,
    required: true
  }
});

module.exports = room = mongoose.model('Room', roomSchema);
