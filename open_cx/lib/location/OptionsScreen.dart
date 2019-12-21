import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_cx/location/components/CustomRaisedButton.dart';
import 'components/constants.dart';
import 'dart:io';

class OptionsScreen extends StatefulWidget {
  OptionsScreen({Key key}) : super(key: key);
  @override
  _OptionsScreen createState() => new _OptionsScreen();
}


class _OptionsScreen extends State<OptionsScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: colorPallete[900],
        body: SingleChildScrollView(
            child:
            new Column(

                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new SpearchLogo(),
                  new Padding(padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01)),

                  new SimpleFlatButton(
                      buttonText: "Options", onPressFunction: null),

                  new VisibilityButton(),
                  new Padding(
                    padding: EdgeInsets.all( MediaQuery.of(context).size.height * 0.05),
                  ),
                  new SimpleButton(buttonText: "Log off", onPressFunction: () => exitapp),

                ])));
  }
  void exitapp()
  {
    exit(0);
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }
}


/// Visibily for button
class VisibilityButton extends StatefulWidget {
  @override
  _VisibilityButton createState() => _VisibilityButton();
}

class _VisibilityButton extends State<VisibilityButton>
{
  bool pressAttention = false;
  @override
  Widget build(BuildContext context) {

    // The GestureDetector wraps the button.
    return GestureDetector(
        onTap: () {
          //  setState( ()  )       // not used might remove later
        },
        // The custom button
        child: Container(
//         margin: const EdgeInsets.only(left: 30.0, right: 30.0),
            margin: const EdgeInsets.symmetric(vertical: 9.0, horizontal: 30),
            height: MediaQuery.of(context).size.height *0.095,
            width: MediaQuery.of(context).size.width *0.86,
            decoration: BoxDecoration(
              border: Border.all(
                color: pressAttention ? colorPallete[100]: colorPallete[200], //                   <--- border color
                width: MediaQuery.of(context).size.height *0.01,
              ),
            ),
            child:
            new RaisedButton(
                key: null,
                color: const Color(0xFFe0e0e0),
                onPressed: () => setState(() => pressAttention = !pressAttention),
                child: new Text(
                  'Toggle Visibility',
                  style: new TextStyle(
                      fontSize: 28.0,
                      color: const Color(0xFF000000),
                      fontWeight: FontWeight.w700,
                      fontFamily: FONTFAMILY),
                ))));
  }
}

