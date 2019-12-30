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
  },
  occupation: {
    type: Number, default: 0
  },
  occupation_list : [{
    value : {type : Number}, 
    date : {type: Date, default: Date.now 
  }}],
  _room: {type: Schema.Types.ObjectId, ref: 'room'}
});

module.exports = talk = mongoose.model('Talk', talkSchema);
