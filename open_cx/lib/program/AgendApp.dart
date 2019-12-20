import 'dart:ui';

import 'package:flutter/material.dart';

import 'Screens/Login/login.dart';

class AgendAppMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          accentColor: Color(0xFF5b78f5),
          primaryColor: Color(0xFF5b78f5),
          cursorColor: Color(0xFF5b78f5),
          textSelectionColor: Color(0xFF5b78f5),
          textSelectionHandleColor: Color(0xFF5b78f5),
          fontFamily: "Ubuntu"),
      home: LoginPage(), //todo MainPage()?
    );
  }
}
