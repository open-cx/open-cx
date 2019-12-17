const mongoose = require('mongoose');

const poiSchema = mongoose.Schema({
  poiId: {
    type: Number,
    required: true
  },
  latitude: {
    type: Number,
    required: true
  },
  longitude: {
    type: Number,
    required: true
  },
  floor: {
    type: Number,
  }
});

module.exports = poi = mongoose.model('POI', poiSchema);
