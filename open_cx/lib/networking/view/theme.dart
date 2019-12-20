import 'package:flutter/material.dart';

const Color whiteColor = Color.fromRGBO(255, 255, 255, 1.0);
const Color blackColor = Color.fromRGBO(0, 0, 0, 1.0);
const Color navyBlueColor = Color.fromRGBO(0, 52, 89, 1.0);
const Color cyanColor = Color.fromRGBO(0, 168, 181, 1.0);
const Color lightCyanColor = Color.fromRGBO(128, 212, 218, 1.0);
const Color lighterCyanColor = Color.fromRGBO(179, 229, 233, 1.0);
const Color veryLightCyanColor = Color.fromRGBO(206, 235, 237, 1.0);
const Color communRedColor = Color.fromRGBO(255, 95, 95, 1.0);
const Color grayColor = Color.fromRGBO(204, 204, 204, 1.0);


ThemeData applicationTheme = new ThemeData(
  brightness: Brightness.light,
  fontFamily: 'Nunito',
  primaryColor: cyanColor,
  buttonColor: cyanColor,
  canvasColor: whiteColor,
  colorScheme: ColorScheme(
    primary:  cyanColor,
    primaryVariant: lightCyanColor,
    onPrimary: whiteColor,
    secondary: whiteColor,
    secondaryVariant: veryLightCyanColor,
    onSecondary: cyanColor,
    surface: whiteColor,
    onSurface: navyBlueColor,
    background: navyBlueColor,
    onBackground: whiteColor,
    error: communRedColor,
    onError: blackColor,
    brightness: Brightness.light
  ),
  textTheme: TextTheme(
    headline: TextStyle(
        fontSize: 72.0, fontWeight: FontWeight.bold, color: navyBlueColor),
    title: TextStyle(fontSize: 30.0, color: navyBlueColor),
    subtitle: TextStyle(fontSize: 25.0, color: navyBlueColor),
    subhead: TextStyle(fontSize: 23.0, color: navyBlueColor),
    caption: TextStyle(fontSize: 15.0, color: lightCyanColor),
    body1: TextStyle(fontSize: 20.0, color:navyBlueColor),
    body2: TextStyle(fontSize: 18.0, color: cyanColor),
    button: TextStyle(fontSize: 25.0, color: whiteColor),
    overline: TextStyle(fontSize: 10.0, color: lighterCyanColor),
  ),
);
