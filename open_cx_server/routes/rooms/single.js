let Room = require('../../models/room');
let Talk = require('../../models/talk');

const singleRoom = require('express').Router();

singleRoom.post('/api/room/update',/* istanbul ignore next */async (req, res) => {
    let { name } = req.query;
    let { occupation } = req.query;
    var date = Date.now()
    
    await Room
        .findOne({ name })
        .populate('talk', null, { start: { $lte: date }, end: { $gte: date } })
        .exec(function (err, room) {
            if (room.talk[0] == undefined) {
                res.json(
                    {
                        code: 404,
                        message: "no talks running at this time"
                    }
                )
            }
            if (room.talk[0] === undefined) {
                return res.json(
                    {
                        code: 404,
                        message: "no talks running at this time"
                    }
                )
            }
            await Talk.findOneAndUpdate({ _id: room.talk[0]._id }, { $set: { occupation }, $push: { occupation_list: { value, date } } }, { new: true, useFindAndModify: false }, (error, talk) => {
                if (error) {
                    res.json(
                        {
                            code: 404,
                            message: error
                        });
                }
                res.json({
                    code: 200,
                    talk: talk
                });
            });
        });
});


module.exports = singleRoom;
