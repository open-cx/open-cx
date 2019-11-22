const User = require('../../models/user');
const tags = require('express').Router();

tags.delete('/:postId', async (req, res) => {
    try {
        const user = await User.findById(req.params.postId);

        Object.keys(req.body).forEach((key) => {
            const removingTag = req.body[key];
            const elems = user[key];
            if(elems.indexOf(removingTag) != -1){
                elems.pop(elems.indexOf(removingTag));
            }
        });
        
        const savedUser = await User.findByIdAndUpdate(req.params.postId, user);


        res.json(savedUser);

    } catch (err) {
        res.statusCode = 500;
        res.json({ message: err });
    }
});


tags.put('/:postId', async (req, res) => {
    try {
        const user = await User.findById(req.params.postId);

        console.log(req.body);
        Object.keys(req.body).forEach((key) => {
            const elems = user[key];
            elems.push(req.body[key]);
        })

        const savedUser = await User.findOneAndUpdate(req.params.postId, user);

        res.json(savedUser);

    } catch (err) {
        res.statusCode = 500;
        res.json({ message: err });
    }
});

module.exports = tags;