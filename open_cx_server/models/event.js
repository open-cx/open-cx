const mongoose = require('mongoose');

const eventSchema = mongoose.Schema({
  eventName: {
    type: String,
    required: true
  },
  description: String,
  poiId: {
    type: String,
    required: true
  },
  room: {
    type: String,
    required: true
  },
  startDate: {
    type: Date,
    required: true
  },
  endDate: {
    type: Date,
    required: true
  }
});

module.exports = event = mongoose.model('Event', eventSchema);
