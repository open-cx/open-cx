import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../Components/displayAllThemes.dart';
import '../../../Model/Talk.dart';
import '../Askkit/Controllers/MyController.dart';
import '../Askkit/Pages/QuestionsPage.dart';


class TalkPage extends StatefulWidget {
  final Talk talk;

  const TalkPage({Key key, this.talk}) : super(key: key);

  @override
  State<StatefulWidget> createState() => TalkPageState();
}

class TalkPageState extends State<TalkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Talk",
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Color(0xFF28316C),
        actions: <Widget>[
          FlatButton(
            child: Text("Questions", style: TextStyle(color: Theme.of(context).canvasColor)),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionsPage(widget.talk, MyController()))),
          )
        ],
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            informationTop(widget.talk),
            showDescription(widget.talk),
            showSpeakers(widget.talk),
            showLocation(widget.talk),
          ],
        ),
      ),
    );
  }
}

Widget informationTop(Talk talk) {
  return Container(
      padding:
      EdgeInsets.only(top: 15.0, left: 20.0, right: 15.0, bottom: 20.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              talk.name,
              style: TextStyle(fontSize: 24.0, color: Colors.black),
            ),
            displayAllThemes(talk.themes),
            Text(
              new DateFormat("EEE, MMM d, HH:mm").format(talk.dateInitial) +
                  new DateFormat(' to HH:mm').format(talk.dateFinal),
              style: TextStyle(fontSize: 14.0, color: Colors.black),
            ),
            Text(
              talk.location,
              style: TextStyle(fontSize: 14.0, color: Colors.black),
            ),
          ]));
}

Widget showDescription(Talk talk) {
  return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
            width: double.infinity,
            child: Container(
              padding:
              EdgeInsets.only(top: 15, bottom: 15, left: 20.0, right: 15.0),
              color: Color(0xffEFEFEF),
              child: Text(
                'Description',
                style: TextStyle(fontSize: 20.0, color: Color(0xff6B6B6B)),
              ),
            )),
        Container(
            padding:
            EdgeInsets.only(top: 20, bottom: 20, left: 20.0, right: 15.0),
            child: Text(
              talk.information,
              style: TextStyle(fontSize: 16.0, color: Colors.black),
            )),
      ]);
}

Widget showSpeakers(Talk talk) {
  return ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: <Widget>[
        SizedBox(
            width: double.infinity,
            child: Container(
              padding:
              EdgeInsets.only(top: 15, bottom: 15, left: 20.0, right: 15.0),
              color: Color(0xffEFEFEF),
              child: Text(
                'Speakers',
                style: TextStyle(fontSize: 20.0, color: Color(0xff6B6B6B)),
              ),
            )),
        showSpeakersName(talk.speakers)
      ]);
}

Widget showSpeakersName(List<String> speakers) {
  return ListView.builder(
    physics: ClampingScrollPhysics(),
    padding: EdgeInsets.only(top: 15, bottom: 15, left: 20.0, right: 15.0),
    shrinkWrap: true,
    itemCount: speakers.length,
    itemBuilder: (context, index) {
      return Text(speakers[index],
          style: TextStyle(fontSize: 18.0, color: Colors.black));
    },
  );
}

Widget showLocation(Talk talk) {
  return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
            width: double.infinity,
            child: Container(
              padding:
              EdgeInsets.only(top: 15, bottom: 15, left: 20.0, right: 15.0),
              color: Color(0xffEFEFEF),
              child: Text(
                'Location',
                style: TextStyle(fontSize: 20.0, color: Color(0xff6B6B6B)),
              ),
            )),
        Container(
            padding: EdgeInsets.only(top: 20, bottom: 15, left: 20.0),
            child: Text(
              talk.location,
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            )),
      ]);
}