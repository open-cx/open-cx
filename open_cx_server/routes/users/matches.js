const User = require('../../models/user');
const FriendRequest = require('../../models/friend_request');
const matches = require('express').Router();


matches.post('/request', async (req, res) => {
    const cache = req.app.get('cache');
    const receiver = req.body.id;
    const currentUser = req.body.user_id;
    const socketId = cache.get(receiver);
    const socket = req.app.get('socketio');

    if(socketId){
        socket.to(socketId).emit('friend_request', currentUser);
    } else {
        const friendRequest = new FriendRequest({
            receiver,
            sender: currentUser
        });

        try {
            const savedMatch = await friendRequest.save();
            res.json(savedMatch);
        }
        catch (err) {
            res.statusCode = 500;
            res.json({ message: err });
        }
    }

    res.send('Friend Request sent!');
});

module.exports = matches;