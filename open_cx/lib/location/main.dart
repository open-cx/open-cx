import 'package:flutter/material.dart';
import 'SearchScreen.dart';
import 'components/constants.dart';

///  Attempt at creating colors
MaterialColor colorCustom = MaterialColor(0xFF880E4F, colorPallete);
/*

/// Class to pass arguments through screens
class ScreenArguments {
  final String title;
  final int userID;
  final String message;

  ScreenArguments(this.title, this.userID, this.message);
}*/

/////////////////////////////////////////////////////////////////////////////////
///////   Below here is the "current app"

class Spearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Generated App',
      theme: new ThemeData(
        primarySwatch: colorCustom,
        primaryColor: const Color(0xFF2196f3),
        accentColor: const Color(0xFF2196f3),
        canvasColor: const Color(0xFFfafafa),
      ),
      initialRoute: '/',
      routes: {
        "/": (context) => new SearchScreen(),
      },
    );
  }
}
/*

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: colorPallete[900],
      body:  new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new SpearchLogoNoBack(),

            new Padding(padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01)),

            new SimpleFlatButton(buttonText: "How to use?", onPressFunction: buttonPressedHowToUse),

            new SimpleButton( buttonText: "Search",onPressFunction: buttonPressedSearch),

            new Padding(
              padding: EdgeInsets.all( MediaQuery.of(context).size.height * 0.05),
            ),

            new SimpleButton( buttonText: "Options" , onPressFunction: buttonPressedOptions),

            new SimpleButton( buttonText: "Check Map", onPressFunction: buttonPressed)

          ]),
    );
  }
  /// Functions implementation
  void buttonPressedSearch(){
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SearchScreen()));
  }
  void buttonPressedHowToUse() {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => HowToUseScren() ));
  }

  void buttonPressed() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MapScreen()));
  }
  void buttonPressedOptions() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => OptionsScreen()));
  }
}





/// LOGIN-screen
class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);
  @override
  _LoginScreen createState() => new _LoginScreen();
}

/// LOGIN-screen
class _LoginScreen extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: colorPallete[900],
        body:  SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                new SafeArea(child:

                new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[

                      /// logo
                      new Container(
                        height: MediaQuery.of(context).size.height * 0.26,
                        child: new Image.asset('assets/images/mainLogo.png', fit: BoxFit.scaleDown),
                      ),

                      new Padding(padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.05)),

                      new Container(
                          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.06 ),
                          child:
                          new Text("Username",
                              //textAlign: TextAlign.center,
                              style: subTitleStyle)),

                      /// Forms to username and password
                      new Container(
                          color: colorPallete[800],
                          child:
                          new TextFormField( obscureText: false,
                            decoration: new InputDecoration(contentPadding: const EdgeInsets.all(16.0)),
                          )            )
                      ,

                      new Padding(padding: EdgeInsets.all( MediaQuery.of(context).size.height * 0.02)),

                      new Container(
                          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.06 ),
                          child:
                          new Text("Password",
                              //textAlign: TextAlign.center,
                              style: subTitleStyle)),

                      new Container(
                          color: colorPallete[800],
                          child:
                          new TextFormField( obscureText: true,
                              decoration: new InputDecoration(contentPadding: const EdgeInsets.all(16.0))
                          )            )
                      ,
                      new Padding(padding: EdgeInsets.all( MediaQuery.of(context).size.height * 0.0125)),
                      new SimpleButton(buttonText: "Login", onPressFunction: logInAttempt),    //TODO define log in function


                    ]))],
            )));
  }
  /// Functions implementation
  void logInAttempt() {
    Navigator.pushReplacementNamed(context, '/main');
//        Navigator.pushNamed(context, '/main');
  }
}
*/
