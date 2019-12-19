import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:open_cx/HelpPage.dart';
import 'package:open_cx/VenuePage.dart';
import 'package:open_cx/PeoplePage.dart';
import 'package:open_cx/ProgramPage.dart';


void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Color.fromRGBO(3, 44, 115, 1), // status bar color
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ESOF Demo',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(3, 44, 115, 1),
      ),
      initialRoute: '/',
      routes: {
        "/": (context) => HomePage(),
        "/yourPage": (context) => MyStatefulWidget()
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
              MyButton(
                  x: 40,
                  y: 30,
                  title: "Main Screen",
                  onPressed: () {
                    Navigator.of(context).pushNamed("/yourPage");
                  }),
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

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  YourProject createState() => YourProject();
}

class YourProject extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Program',
      style: optionStyle,
    ),
    Text(
      'Index 1: Venue',
      style: optionStyle,
    ),
    Text(
      'Index 2: People',
      style: optionStyle,
    ),
    ];

  final List<Widget> _children = [
    ProgramPage(),
    VenuePage(),
    PeoplePage(),
    HelpPage()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("<Programming> 2020"),
      ),
      body: Center(
        child: _children.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            title: Text('Program'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.theaters),
            title: Text('Venue'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            title: Text('People'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            title: Text('Help'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
        unselectedItemColor: Color.fromRGBO(3, 44, 115, 1),
        unselectedLabelStyle: TextStyle(color: Color.fromRGBO(3, 44, 115, 1)),
        showUnselectedLabels: true,
      ),
    );
  }
}
