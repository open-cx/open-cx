const User = require('../../models/user');
const socials = require('express').Router();

socials.delete('/:postId/:key', async (req, res) => {
    const key = req.params.key;

    if(!key){
        res.statusCode = 400;
        res.send("Invalid social key.");
        return;
    }
    
    try {
        const user = await User.findById(req.params.postId);

        if(!user){
            res.statusCode = 404;
            res.send("User not found.");
            return;
        }
        
            if(!user.socials[key]){
                res.statusCode = 404;
                res.send("User doesn't have that social.");
                return;
            }
            
            console.log(user.socials[key]);

            user.socials[key] = null;
            
            console.log(user.socials[key]);

        const savedUser = await User.findByIdAndUpdate(req.params.postId, user);


        res.json(savedUser);

    } catch (err) {
        res.statusCode = 500;
        res.json({ message: err });
    }
});


socials.put('/:postId', async (req, res) => {
    const key = Object.keys(req.body)[0];

    if(!key){
        res.statusCode = 400;
        res.send("Invalid social key.");
        return;
    }
    
    try {
        const user = await User.findById(req.params.postId);
        
            if(user.socials[key]){
                res.statusCode = 406; 
                res.send("User already has that social.");
                return;
            }

            user.socials[key] = req.body[key];

        const savedUser = await User.findByIdAndUpdate(req.params.postId, user);

        res.json(savedUser);

    } catch (err) {
        res.statusCode = 500;
        res.json({ message: err });
    }
});

module.exports = socials;