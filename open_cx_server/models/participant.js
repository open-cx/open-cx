const mongoose = require('mongoose');

const participantSchema = mongoose.Schema({
  username: {
    type: String,
    required: true
  }
});

module.exports = participant = mongoose.model('Participant', participantSchema);
