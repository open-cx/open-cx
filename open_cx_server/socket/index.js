const NodeCache = require('node-cache');
const cache = new NodeCache();
const FriendRequest = require('../models/friend_request');
const User = require('../models/user');


module.exports = (io) => {
    io.on('connection',async (socket) => {
        console.info('User connected');
        const user = socket.handshake.headers['user_id'];
        if(user){
            cache.set(user, socket.id);
            socket.emit('success');

            const friendRequests = await FriendRequest.find( { receiver: user, unread: true } );

            friendRequests.forEach(async friendRequest => {
                const user = await User.findById(friendRequest.sender);
                socket.emit('friend_request', user.fullname);
            });

            friendRequests.forEach(async (friendRequest) => {
                friendRequest.unread = false;
                await FriendRequest.findByIdAndUpdate(friendRequest.id, friendRequest);
            });


            socket.on('disconnect', () => {
                cache.del(user);
            });


        } else{
            socket.emit('failure',  "No user ID found");
        }
        
    });

    return cache;
}