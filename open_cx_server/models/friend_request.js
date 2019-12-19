const mongoose = require('mongoose');

const friendRequestSchema = mongoose.Schema({
    receiver: {
        type: String,
        required: true
    },
    sender: {
        type: String,
        required: true
    },
    unread: {
        type: Boolean,
        required: true
    },
});

module.exports = friendRequest = mongoose.model('FriendRequest', friendRequestSchema);
