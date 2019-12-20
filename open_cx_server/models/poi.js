const mongoose = require('mongoose');

const poiSchema = mongoose.Schema({
  id: {
    type: Number,
    required: true
  },
  latitude: {
    type: Number,
    min: -90,
    max: 90,
    required: true
  },
  longitude: {
    type: Number,
    min: -180,
    max: 180,
    required: true
  },
  title: {
    type: String,
    required: true
  },
  description: {
      type: String,
      required: true
  },
  poiType: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'POIType',
    required: true
  },
  floors: {
    type: [Number],
    required: true
  },
  keywords: {
    type: [String],
    required: false
  },

});

module.exports = POI = mongoose.model('POI', poiSchema);
