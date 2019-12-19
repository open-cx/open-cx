let Participant = require('../../models/participant');

const express = require('express');
const router = express.Router();

// Gets all of the participants
router.get('/', async (req, res) => {
  Participant.find({}, (err, participants) => {
    if(err)
      res.sendStatus(400);
    res.status(200).send(participants);

  });
});

// Gets all of a specific Participant's info from the database
router.get('/:postId',  (req, res) => {
  Participant.findOne({_id: req.params.postId}, (err, participant) => {
    if(err)
      res.sendStatus(400);
    res.status(200).send(participant);

  });
})

// Delete Participant from database
router.post('/:postId',  (req, res) => {
  Participant.findOneAndDelete({_id: req.params.postId})
  res.sendStatus(200);
});

// Adds a Participant to the database
router.post('/',  (req, res) => {
  new Participant({
    username: req.body.participant.username,
  }).save();
  res.sendStatus(200);
});

//Check in an user
router.post('/checkin/:postId', (req,res) => {
  Participant.findOne({ id: req.params.postId }, (err, participant) => {
    if (err) 
      return res.status(404).send(err);
    participant.checkedIn = true;
    participant.save();
    return res.status(200).send("Success");
  })
});

//Verifies if a participant is checked in
router.post('/verifyCheckedIn/:postId', (req,res) => {
  Participant.findOne({ id: req.params.postId }, (err, participant) => {
    if (err) 
      return res.status(404).send(err);
    if(participant.checkedIn)
      return res.status(200).send("Success");
    else
      return res.status(400).send("NotCheckedIn");
  }) 
});

//Verifies if a participant can receive gift bag
router.post('/canDeliver/:postId', (req,res) => {
  Participant.findOne({ id: req.params.postId }, (err, participant) => {
    if (err) 
      return res.status(404).send(err);
    if(participant.delivered)
      return res.status(400).send("DontDeliver");
    else
      return res.status(200).send("Success");
  }) 
});

//Sets the participant's gift bag as delivered
router.post('/setDelivered/:postId', (req,res) => {
  Participant.findOne({ id: req.params.postId }, (err, participant) => {
    if (err) 
      return res.status(404).send(err);
      participant.delivered= true;
      participant.save();
      return res.status(200).send("Success");
    
  }) 
});
module.exports = router;

