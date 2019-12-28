import 'package:flutter/material.dart';
import 'package:open_cx/location/MapScreen.dart';
import 'package:open_cx/location/components/CustomRaisedButton.dart';
import 'package:open_cx/location/components/constants.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:open_cx/location/users.dart';
import 'package:open_cx/location/Map2.dart';

//import 'package:http/http.dart' as http;

class SpeakerUserPage extends StatelessWidget {
  final String name;
  final String company;
  final List nextTalk;

  SpeakerUserPage({Key key, @required this.name, @required this.company, @required this.nextTalk}) : super(key: key);
  @override

  Widget build(BuildContext context) {
    bool pressAttention = false;
    return new Scaffold(
        backgroundColor: colorPallete[900],
        body: SingleChildScrollView(
            child: Stack(
                children: <Widget>[
                  new SafeArea(child:
                  new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[

                        new Row(
                            children: <Widget>[
                              new InkWell(
                                onTap: () { Navigator.pop(context);},
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width * 0.03),
                                  alignment: Alignment.topLeft,
                                  color: colorPallete[900],
                                  child: Image.asset('assets/images/backArrow.png',fit: BoxFit.scaleDown,
                                      width: (MediaQuery.of(context).size.height * 0.05), height: (MediaQuery.of(context).size.height* 0.05)),
                                ),
                              ),

                              new AddToContacts(this.name)
                            ]),

                        //TODO -> Add a button to "Add to Contacts here"

//              new Padding(padding:  EdgeInsets.all(MediaQuery.of(context).size.width*0.01)),
//
//
//                  new Text(
//                      "User1",
//                      textAlign: TextAlign.center,
//                      style: subTitleStyle),


                        new Container(
                            color: colorPallete[700],
                            width: MediaQuery.of(context).size.width *0.6,
                            height: MediaQuery.of(context).size.width *0.6,
                            child:
                            PhotoView(
                              imageProvider: NetworkImage("https://sigarra.up.pt/feup/en/FOTOGRAFIAS_SERVICE.foto?pct_cod=231081"),
                              initialScale: PhotoViewComputedScale.contained,
                            )
                        ),

                        new Padding(padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01)),


                        /// Information Container
                        new Container(
                          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width*0.8,

                          child:
                          new Stack(
                              children: <Widget>[
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[

                                    new Text("Full Name:",
                                        style: subTitleStyle),
                                    new Container(
                                      color: colorPallete[800],
                                      padding: EdgeInsets.all(3),
                                      width: MediaQuery.of(context).size.width*0.8,
                                      child:
                                      new Text( name ,style: infoTitleStyle),
                                    )
                                    ,
                                    new Padding(padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01)),

                                    new Text("Company:",style: subTitleStyle),
                                    new Container(
                                      color: colorPallete[800],
                                      padding: EdgeInsets.all(3),
                                      width: MediaQuery.of(context).size.width*0.8,
                                      child:
                                      new Text(company,style: infoTitleStyle),
                                    ),


                                    new Text("Next Talk:",style: subTitleStyle),
                                    new Container(
                                      color: colorPallete[800],
                                      padding: EdgeInsets.all(3),
                                      width: MediaQuery.of(context).size.width*0.8,
                                      child:
                                      new Text(nextTalk[0] +"\n" + nextTalk[2],style: infoTitleStyle),
                                    )
                                  ],
                                )]),
                        ),

                        new Padding(padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.04)),

//                        new SimpleButton(
//                            buttonText: "Show on Map",
//                            onPressFunction: () {    Navigator.push(
//                                context, MaterialPageRoute(builder: (context) => MapScreen()));}

                        new SimpleButton(
                            buttonText: "Show on Map",
                            onPressFunction: () {    Navigator.push(
                                context, MaterialPageRoute(builder: (context) => Map2(lat: nextTalk[1][1], long: nextTalk[1][2], name: nextTalk[0] + "  " + nextTalk[2])));}

                        ),

                      ]))])));
  }

//
//  void goToSearchSpeaker()
//  {
//    Navigator.push(
//        context, MaterialPageRoute(builder: (context) => MapScreen()));
//  }
}




class UserPage extends StatelessWidget {
  final String name;
  final String company;
  final double last_lat;
  final double last_long;

  UserPage({Key key, @required this.name, @required this.company, @required this.last_lat, @required this.last_long}) : super(key: key);
  @override

  Widget build(BuildContext context) {
    bool pressAttention = false;
    return new Scaffold(
        backgroundColor: colorPallete[900],
        body: SingleChildScrollView(
            child: Stack(
                children: <Widget>[
                  new SafeArea(child:
                  new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[

                        new Row(
                            children: <Widget>[
                              new InkWell(
                                onTap: () { Navigator.pop(context);},
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width * 0.03),
                                  alignment: Alignment.topLeft,
                                  color: colorPallete[900],
                                  child: Image.asset('assets/images/backArrow.png',fit: BoxFit.scaleDown,
                                      width: (MediaQuery.of(context).size.height * 0.05), height: (MediaQuery.of(context).size.height* 0.05)),
                                ),
                              ),

                              new AddToContacts(this.name)
                            ]),

                        //TODO -> Add a button to "Add to Contacts here"

//              new Padding(padding:  EdgeInsets.all(MediaQuery.of(context).size.width*0.01)),
//
//
//                  new Text(
//                      "User1",
//                      textAlign: TextAlign.center,
//                      style: subTitleStyle),


                        new Container(
                            color: colorPallete[700],
                            width: MediaQuery.of(context).size.width *0.6,
                            height: MediaQuery.of(context).size.width *0.6,
                            child:
                            PhotoView(
                              imageProvider: NetworkImage("https://sigarra.up.pt/feup/en/FOTOGRAFIAS_SERVICE.foto?pct_cod=231081"),
                              initialScale: PhotoViewComputedScale.contained,
                            )
                        ),

                        new Padding(padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01)),


                        /// Information Container
                        new Container(
                          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width*0.8,

                          child:
                          new Stack(
                              children: <Widget>[
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[

                                    new Text("Full Name:",
                                        style: subTitleStyle),
                                    new Container(
                                      color: colorPallete[800],
                                      padding: EdgeInsets.all(3),
                                      width: MediaQuery.of(context).size.width*0.8,
                                      child:
                                      new Text( name ,style: infoTitleStyle),
                                    )
                                    ,
                                    new Padding(padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01)),

                                    new Text("Company:",style: subTitleStyle),
                                    new Container(
                                      color: colorPallete[800],
                                      padding: EdgeInsets.all(3),
                                      width: MediaQuery.of(context).size.width*0.8,
                                      child:
                                      new Text(company,style: infoTitleStyle),
                                    ),

                                  ],
                                )]),
                        ),

                        new Padding(padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.04)),

//                        new SimpleButton(
//                            buttonText: "Show on Map",
//                            onPressFunction: () {    Navigator.push(
//                                context, MaterialPageRoute(builder: (context) => MapScreen()));}

                        new SimpleButton(
                            buttonText: "Show on Map",
                            onPressFunction: () {    Navigator.push(
                                context, MaterialPageRoute(builder: (context) => Map2(lat: last_lat, long: last_long, name: name)));}

                        ),

                      ]))])));
  }

//
//  void goToSearchSpeaker()
//  {
//    Navigator.push(
//        context, MaterialPageRoute(builder: (context) => MapScreen()));
//  }
}




/// Add to Contacts button
class AddToContacts extends StatefulWidget {
  final String name;
  AddToContacts(this.name);
  @override
  _AddToContacts createState() => _AddToContacts(name);
}

class _AddToContacts extends State<AddToContacts>
{
  final String name;
  _AddToContacts(this.name);
  bool pressAttention = false;
  @override
  Widget build(BuildContext context) {

    // The GestureDetector wraps the button.
    return Container(
        width: MediaQuery.of(context).size.width*0.88,
        child:
        GestureDetector(
            onTap: () {
              //  setState( ()  )       // not used might remove later
            },
            // The custom button
            child:
            Align(
                alignment: Alignment.topRight,
                child:
                new Container(
                    margin: const EdgeInsets.symmetric(vertical: 9.0,),
                    height: MediaQuery.of(context).size.height *0.063,
                    width: MediaQuery.of(context).size.width *0.48,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: pressAttention ? colorPallete[100]: colorPallete[200], //                   <--- border color
                        width: MediaQuery.of(context).size.height *0.009,
                      ),
                    ),
                    child:
                    new RaisedButton(
                        key: null,
                        color: const Color(0xFFe0e0e0),
                        onPressed: () {setState(() => pressAttention = !pressAttention); if(!contact.contains(this.name))contact.add(this.name);},
                        child: new Text(
                          'Add To Contacts',
                          style: new TextStyle(
                              fontSize: 18.0,
                              color: const Color(0xFF000000),
                              fontWeight: FontWeight.w700,
                              fontFamily: FONTFAMILY),
                        ))))));
  }
}