const mongoose = require('mongoose');

const poiSchema = mongoose.Schema({
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
