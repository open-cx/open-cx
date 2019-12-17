const mongoose = require('mongoose');

const eventSchema = mongoose.Schema({
  eventName: {
    type: String,
    required: true
  },
  description: String,
  room: {
    type: String,
    required: true
  },
  startDate: {
    type: Date,
    required: true
  },
  tags: {
    type:[String]
  }
});

module.exports = event = mongoose.model('Event', eventSchema);
