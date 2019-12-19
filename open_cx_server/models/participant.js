const mongoose = require('mongoose');

const participantSchema = mongoose.Schema({
  username: {
    type: String,
    required: true
  },
  checkedIn: {
    type: Boolean,
    default: false
  },
  delivered: {
    type: Boolean,
    default: false
  }
});

module.exports = participant = mongoose.model('Participant', participantSchema);
