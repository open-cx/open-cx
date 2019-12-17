const mongoose = require('mongoose');

const connectionSchema = mongoose.Schema({
    connectionId: {
        type: Number,
        required: true
    },
    connections: {
        type: [Number],
        required: true
    }
});

module.exports = connection = mongoose.model('Connection', connectionSchema);
