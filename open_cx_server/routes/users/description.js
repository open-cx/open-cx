const User = require('../../models/user');
const description = require('express').Router();

description.post('/:postId', async (req, res) => {
    if(!req.body.description) {
        res.statusCode = 400;
        res.send("Invalid description.");
        return;
    }
    
    try {
        const user = await User.findById(req.params.postId);

        if(!user){
            res.statusCode = 404;
            res.send("User not found.");
            return;
        }
        
        user.description = req.body.description;
        
        const savedUser = await User.findByIdAndUpdate(req.params.postId, user);


        res.json(savedUser);

    } catch (err) {
        res.statusCode = 500;
        res.json({ message: err });
    }
});

module.exports = description;