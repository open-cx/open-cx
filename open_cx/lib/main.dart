import 'package:flutter/material.dart';
import 'package:open_cx/Screens/Search/InitialLoadingScreen.dart';
import 'package:open_cx/controller/Controller.dart';
import 'AgendApp.dart';
import 'package:flutter/services.dart';
import 'constants/Utility.dart' as Utility;

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Color.fromRGBO(3, 44, 115, 1), // status bar color
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // Fecth the URL for the json needed for the bluetooth searching (AMA)
    Controller.instance().updateURLPath(Utility.jsonURL);

    return MaterialApp(
      title: 'ESOF Demo',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(3, 44, 115, 1),
      ),
      initialRoute: '/',
      routes: {
        "/": (context) => HomePage(),
        "/yourPage": (context) => YourProject(),
        "/agendAppMain": (context) => AgendAppMain(),
        "/agendAppLoad": (context) => InitialLoadingScreen()  // On click go to the loading screen (loads the bluetooth search database from the conference JSON)
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Color.fromRGBO(3, 44, 115, 1),
          child: Stack(
            children: <Widget>[
              Center(
                  child: Text("openCX",
                      style: TextStyle(fontSize: 32, color: Colors.white))),
              MyButton(x: 14, y: 60, title: "Ex", onPressed: () {}),
              MyButton(x: 70, y: 60, title: "AMAgendAppskkit", onPressed: () => Navigator.of(context).pushNamed("/agendAppLoad"))
            ],
          ),
        ),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  MyButton({this.x, this.y, this.title, this.onPressed});

  final int x;
  final int y;
  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: (x / 100) * MediaQuery.of(context).size.width,
      top: (y / 100) * MediaQuery.of(context).size.height,
      child: FloatingActionButton(
        onPressed: onPressed,
        backgroundColor: Colors.white,
        child: Text(
          title,
          style: TextStyle(color: Colors.black),
        ),
        heroTag: title,
      ),
    );
  }
}

class YourProject extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Project"),
      ),
      body: Center(
        child: Text("MyApp"),
      ),
    );
  }
}