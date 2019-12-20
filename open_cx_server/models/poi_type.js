const mongoose = require('mongoose');

const poiTypeSchema = mongoose.Schema({
  id: {
    type: Number,
    required: true
  },
  name: {
    type: String,
    required: true
  }
});

module.exports = POIType = mongoose.model('POIType', poiTypeSchema);
