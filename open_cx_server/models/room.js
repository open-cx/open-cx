const mongoose = require('mongoose');

const roomSchema = mongoose.Schema({
  name: {
    type: String,
    required: true
  },
  talk: [{
      type: Schema.Types.ObjectId, ref: 'talk'
  }]
});

module.exports = room = mongoose.model('Room', roomSchema);
