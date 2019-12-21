import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_cx/location/OptionsScreen.dart';
import 'package:open_cx/location/components/constants.dart';
import 'components/CustomRaisedButton.dart';
import 'package:open_cx/location/SearchScreen_contacts.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key key}) : super(key: key);
  @override
  _SearchScreen createState() => new _SearchScreen();
}

class _SearchScreen extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: colorPallete[900],
        body: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[

//              new Image.asset( 'assets/images/toplogo_light.png', fit: BoxFit.scaleDown),

              new SpearchLogoNoBack(),

              new Padding(padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01)),

              new SimpleFlatButton(buttonText: "Peers", onPressFunction: null),

//              new SimpleButton( onPressFunction: goToSearchPerson, buttonText: "Search your Peers"),
              new SimpleButton( onPressFunction: goToContactList, buttonText: "Contact List"),

              new Padding(
                padding: const EdgeInsets.all(24.0),
              ),


              new SimpleFlatButton(buttonText: "Event", onPressFunction: null),

              new SimpleButton(
                  onPressFunction: goToSearchOptions, buttonText: "Options"),
             // new SimpleButton(onPressFunction: goToEventName, buttonText: "Event Name"),

            ]));
  }

  /*void goToEventName()
  {
    Navigator.of(context).push(
        CupertinoPageRoute<Null>(builder: (BuildContext context) {
          return new SearchScreen_event();
        }));
  }

  void goToSearchSpeaker() {
    Navigator.of(context).push(
        CupertinoPageRoute<Null>(builder: (BuildContext context) {
          return new SearchScreenSpeaker();
        }));
  }

  void goToSearchPerson(){
    Navigator.of(context).push(
        CupertinoPageRoute<Null>(builder: (BuildContext context) {
          return new SearchScreen_person();
        }));
  }
*/

  void goToContactList(){
    Navigator.of(context).push(
        CupertinoPageRoute<Null>(builder: (BuildContext context) {
          return new SearchScreen_contacts();
        }));
  }

  void goToSearchOptions() {
    Navigator.of(context).push(
        CupertinoPageRoute<Null>(builder: (BuildContext context) {
        return new OptionsScreen();
        }));
  }

}
