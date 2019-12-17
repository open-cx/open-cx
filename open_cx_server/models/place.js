const mongoose = require('mongoose');

const placeSchema = mongoose.Schema({
    placeName: {
        type: String,
        required: true
    },
    poiId: {
        type: Number,
        required: true
    },
    room: {
        type: String,
        required: true
    }
});

module.exports = place = mongoose.model('Place', placeSchema);
