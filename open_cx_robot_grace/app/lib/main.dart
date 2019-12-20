import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grace/slider.dart';
import 'package:flutter_vlc_player/vlc_player.dart';
import 'package:flutter_vlc_player/vlc_player_controller.dart';
import 'dart:io';

import 'grace.dart';
import 'joystick.dart';

final myController = TextEditingController();
BoardGame game;
void main() async {
  // Force landscape device left orientation
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft]);

  // Hide status bar
  await SystemChrome.setEnabledSystemUIOverlays([]);

  /*SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Color.fromRGBO(3, 44, 115, 1), // status bar color
  ));
*/
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Grace',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(3, 44, 115, 1),
      ),
      initialRoute: '/',
      routes: {
        "/": (context) => HomePage(),
        "/grace_controller": (context) => MyJoystick(),
        "/grace_call": (context) => GraceCall(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double x = 5 * MediaQuery.of(context).size.width / 16;
    final double y = MediaQuery.of(context).size.height / 3;
    double sliderValue = 5;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/robot.jpg"),
                  fit: BoxFit.cover)),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20),
                Center(
                    child: Text(
                  "Grace",
                  style: TextStyle(
                      fontSize: 32,
                      color: Colors.lightBlue[900],
                      fontWeight: FontWeight.bold),
                )),
                SizedBox(height: 75),
                Container(
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: myController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)),
                            borderSide: BorderSide(
                                color: Colors.lightBlue[900], width: 2),
                          ),
                          hintText: 'Enter Grace\'s IP address'),
                    )),
                RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Text("Control Grace"),
                    color: Colors.blue[800],
                    textColor: Colors.white,
                    onPressed: () {
                      if(game == null){
                        game = BoardGame(myController.text);
                      }
                      Navigator.of(context).pushNamed("/grace_controller");
                    })
              ]),
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
      width: 100,
      height: 70,
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

class GraceCall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Grace Call"),
      ),
      body: Center(
        child: Text("You are calling Grace!"),
      ),
    );
  }
}

class MyJoystick extends StatefulWidget {
  /*GestureDetector(
    behavior: HitTestBehavior.opaque,
    onPanStart: game.onPanStart,
    onPanUpdate: game.onPanUpdate,
    onPanEnd: game.onPanEnd,
    child: game.widget,
  ), */

  @override
  _MyJoystickState createState() => _MyJoystickState();
}

class _MyJoystickState extends State<MyJoystick> {
  String _stringURL;
  VlcPlayerController _vlcPlayerController;

  void reconnect() async {
    print('Reconnecting');
    game.socket = await Socket.connect(game.ip, 8080);
  }

  @override
  void initState() {
    super.initState();
    _vlcPlayerController = new VlcPlayerController();
  }

  void _incrementCounter() {
    setState(() {
      if (_stringURL != null) {
        _stringURL = null;
      } else {
        _stringURL = "http://" + myController.text + ":8082";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    double controlsY = MediaQuery.of(context).size.height;
    print(controlsY);
    double controlsX = MediaQuery.of(context).size.width;
    print(controlsX);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: Icon(_stringURL == null ? Icons.play_arrow : Icons.pause),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: Stack(
            children: [
              game.widget,
              //Robots Vision Layer
              _stringURL != null
                  ? Center(
                      child: Container(
                          child: new VlcPlayer(
                        defaultWidth: controlsX.toInt(),
                        defaultHeight: controlsY.toInt(),
                        url: _stringURL,
                        controller: _vlcPlayerController,
                        placeholder: Container(
                          color: Colors.lightBlue[900],
                        ),
                      )),
                    )
                  : Container(
                      child: Center(
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: "GraceVision OFF",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ))
                          ]),
                        ),
                      ),
                      color: Colors.lightBlue[700],
                    ),
              //Robots Controls Layer
              Column(
                children: [
                  Center(
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Text("Reconnect"),
                    color: Colors.blue[800],
                    textColor: Colors.white,
                    onPressed: () {
                      if(game.socket != null){
                        reconnect();
                      }
                      Navigator.of(context).pushNamed("/grace_controller");
                    }),
              ),
                  SizedBox(height: controlsY / 15.5),

                  Row(
                    children: [
                      SizedBox(width: controlsX / 10.971),
                      Transform.scale(
                        scale: controlsY / 411.428 * 2,
                        child: Transform.translate(
                          offset: Offset(controlsX / 27.43, controlsY / 8.754),
                          child: Joystick(
                            onChange: (Offset delta) =>
                                game.angularVelChange(delta),
                          ),
                        ),
                      ),
                      Spacer(),
                      Transform.scale(
                        scale: controlsY / 411.428 * 1.5,
                        child: Transform.translate(
                          offset: Offset(controlsX / (-82.286), 0),
                          child: MySlider(
                            onChange: (Offset delta) =>
                                game.linearVelChange(delta),
                          ),
                        ),
                      ),
                      SizedBox(width: controlsX / 8.229),
                    ],
                  ),
                  SizedBox(height: controlsY / 17.143),
                ],
              ),
            ],
          ),
        ));
  }
}
