const profile = require("express").Router();
const User = require("../../models/user");

profile.get("/:postId", async (req, res) => {

    try {
        const user = await User.findById(req.params.postId);
        res.json(user);
    } catch (err) {
        res.json({ message: err });
    }
});

module.exports = profile;
