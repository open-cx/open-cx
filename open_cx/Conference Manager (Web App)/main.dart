import 'package:flutter/material.dart';
import 'package:web_app/SessionScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  final SessionScreen sessionScreen = new SessionScreen();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Web App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: sessionScreen,
    );
  }
}