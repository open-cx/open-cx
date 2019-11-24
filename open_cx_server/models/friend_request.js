const mongoose = require('mongoose');

const friendRequestSchema = mongoose.Schema({
    receiver: String,
    sender: String 
});

module.exports = friendRequest = mongoose.model('FriendRequest', friendRequestSchema);
