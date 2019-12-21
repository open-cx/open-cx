import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_cx/location/components/CustomRaisedButton.dart';
import 'package:open_cx/location/components/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:open_cx/location/users.dart';
import 'package:open_cx/location/UserPage.dart';
import 'package:open_cx/location/MapScreen.dart';

const thisblue = Color(0xFF243470);


class SearchScreen_contacts extends StatefulWidget {

  SearchScreen_contacts({Key key}) : super(key: key);
  @override
  _SearchScreen_contacts createState() => new _SearchScreen_contacts();

}
List userList =[];


class _SearchScreen_contacts extends State<SearchScreen_contacts> {


  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: colorPallete[900],
        body:
        new SingleChildScrollView(
            child: Stack(
                children: <Widget> [
                  new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        new SpearchLogo(),
                        new Padding(padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01)),

                        new SimpleFlatButton(buttonText: "Spearch your Contacts", onPressFunction: null),
                        new SimpleButton( onPressFunction: goToAddPeople, buttonText: "Add more contacts"),
                        new Container(
                          margin: const EdgeInsets.all(10.0),
                          color: colorPallete[800],
                          alignment: Alignment.topCenter,
                          width: MediaQuery.of(context).size.width * 0.90,
                          height: MediaQuery.of(context).size.height * 0.58,
                          child:
                          ListView.separated(
                            separatorBuilder: (BuildContext context, int index) => const Divider(
                              thickness: 3,
                              color: thisblue,
                            ),
                            // Let the ListView know how many items it needs to build.
                            itemCount: contact.length,
                            itemBuilder: (context, index) {
                              final item = contact[index];
                              final user = getUser(item);
                              debugPrint(user[3]);
                              //final company = companies[index];
                              //final nxt_talk = talks[index];
                              return ListTile(
                                leading:
                                CircleAvatar(
                                  backgroundImage: NetworkImage("https://sigarra.up.pt/feup/en/FOTOGRAFIAS_SERVICE.foto?pct_cod=231081"),),
                                title: Text(item,style: infoTitleStyle,),
                                onTap: () {
                                  print('CLICKED ON: ' + item);
                                  if(user[3].contains("speaker")) {
                                    Navigator.push(
                                        context, MaterialPageRoute(
                                        builder: (context) =>
                                            SpeakerUserPage(name: user[0],
                                              company: user[4],
                                              nextTalk: user[5],)));
                                  }
                                  else{
                                    Navigator.push(
                                        context, MaterialPageRoute(builder: (context) => UserPage(name: user[0], company: user[4], last_lat: user[1], last_long: user[2],)));
                                  }
                                  new MapScreen();},
                              );
                            },
                          ),
                        ),
                      ])])));
  }

  getUser(item){
    for(var x in users){
      if(x.contains(item))
        return x;
    }
  }

  void goToAddPeople(){
    Navigator.of(context).push(
        CupertinoPageRoute<Null>(builder: (BuildContext context) {
          return new AddScreen_contacts();
        }));
  }

}

class AddScreen_contacts extends StatefulWidget{

  AddScreen_contacts({Key key}) : super(key: key);
  @override
  _AddScreen_contacts createState() => new _AddScreen_contacts();

}


class _AddScreen_contacts extends State<AddScreen_contacts> {


  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: colorPallete[900],
        body:
        new SingleChildScrollView(
            child: Stack(
                children: <Widget> [
                  new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        new SpearchLogo(),
                        new Padding(padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01)),

                        new SimpleFlatButton(buttonText: "Spearch your Contacts", onPressFunction: null),
                        new Container(
                          margin: const EdgeInsets.all(10.0),
                          color: colorPallete[800],
                          alignment: Alignment.topCenter,
                          width: MediaQuery.of(context).size.width * 0.90,
                          height: MediaQuery.of(context).size.height * 0.58,
                          child:
                          ListView.separated(
                            separatorBuilder: (BuildContext context, int index) => const Divider(
                              thickness: 3,
                              color: thisblue,
                            ),
                            // Let the ListView know how many items it needs to build.
                            itemCount: users.length,
                            itemBuilder: (context, index) {
                              final item = users[index];

                              return ListTile(
                                leading:
                                CircleAvatar(
                                  backgroundImage: NetworkImage("https://sigarra.up.pt/feup/en/FOTOGRAFIAS_SERVICE.foto?pct_cod=231081"),),
                                title: Text(item[0],style: infoTitleStyle,),
                                onTap: () {
                                  print('CLICKED ON: ' + item[0]);

                                  Navigator.push(
                                      context, MaterialPageRoute(builder: (context) => UserPage(name: item[0], company: item[4], last_lat: item[1], last_long: item[2],)));
                                  new MapScreen();},
                              );
                            },
                          ),
                        ),
                      ])])));
  }


}