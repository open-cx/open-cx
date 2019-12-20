import 'package:flutter/material.dart';

void showInSnackBar(GlobalKey<ScaffoldState> scaffoldKey, String value) {
  scaffoldKey.currentState?.removeCurrentSnackBar();
  scaffoldKey.currentState.showSnackBar(new SnackBar(
    content: new Text(
      value,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontFamily: "WorkSansSemiBold"),
    ),
    backgroundColor: Colors.black,
    duration: Duration(seconds: 3),
  ));
}