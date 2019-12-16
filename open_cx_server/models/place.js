const mongoose = require('mongoose');

const placeSchema = mongoose.Schema({
  placeName: {
    type: String,
    required: true
  },
  description: String,
  pointID: {
    type: String,
    required: true
  },
  room: {
    type: String,
    required: true
  }
});

module.exports = event = mongoose.model('Place', placeSchema);