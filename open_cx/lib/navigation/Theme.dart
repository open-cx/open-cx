import 'package:flutter/material.dart';

const Color titleColor = Colors.white;
const Color backgroundColor = Color(0xffff9900);
const String defaultFontFamily = 'Roboto';
const Color open_cx_color = Color(0xFF5b78f5);
const Color open_cx_color_darker = Color(0xFF28316C);


ThemeData applicationTheme = new ThemeData(

  primaryColor: open_cx_color_darker,
  backgroundColor: open_cx_color,
  //fontFamily: 'Roboto',

  textTheme: const TextTheme(
    headline: const TextStyle(fontSize: 25.0, color: Colors.white, fontWeight: FontWeight.w400, fontFamily: 'Pacifico'),
    title: const TextStyle(fontSize: 60.0, color: open_cx_color_darker, fontWeight: FontWeight.w400, fontFamily: 'Pacifico'),
    display1: const TextStyle(fontSize: 40.0, color: open_cx_color_darker, fontFamily: 'Pacifico'),
    body2: const TextStyle(fontSize: 20.0, color: open_cx_color_darker, fontWeight: FontWeight.w300, fontFamily: 'Roboto'),
  ),
);