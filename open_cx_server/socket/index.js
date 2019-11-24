const NodeCache = require('node-cache');
const cache = new NodeCache();


module.exports = (io) => {
    io.on('connection',(socket) => {
        console.log('User connected');
        const user = socket.handshake.headers['user_id'];
        if(user){
            cache.set(user, socket);
            socket.emit('success');
    
            socket.on('disconnect', () => {
                cache.del(user);
            });
        } else{
            socket.emit('failure',  "No user ID found");
        }
        
    });

    return cache;
}