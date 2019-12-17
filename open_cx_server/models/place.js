const mongoose = require('mongoose');

const placeSchema = mongoose.Schema({
    poiId: {
        type: String,
        required: true
    },
    room: {
        type: String,
        required: true
    }
});

module.exports = place = mongoose.model('Place', placeSchema);
