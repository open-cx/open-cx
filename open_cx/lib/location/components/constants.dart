import 'package:flutter/material.dart';

const Map<int, Color> colorPallete = {
  50: Color.fromRGBO(36, 52, 112, .1),
  100: Color.fromRGBO(255, 0, 0, 1),    // red
  200: Color.fromRGBO(0, 255, 32, 1),   //green
  300: Color.fromRGBO(36, 52, 112, .4),
  400: Color.fromRGBO(36, 52, 112, .5),
  500: Color.fromRGBO(36, 52, 112, .6),
  600: Color.fromRGBO(0, 0, 0, 1),   // black

  700: Color.fromRGBO(36, 52, 112, .9),
  
  800: Color.fromRGBO(255, 255, 255, 1),   // white
  900: Color.fromRGBO(36, 52, 112, 1),    //Background blue
};

const String FONTFAMILY = "Roboto";

final TextStyle subTitleStyle =  TextStyle(
      fontSize: 22,
      color: colorPallete[800], 
      fontWeight: FontWeight.w400,
      fontFamily: FONTFAMILY,
      );

final TextStyle infoTitleStyle =  TextStyle(
  fontSize: 24,
  backgroundColor: colorPallete[800],
  color: colorPallete[600],
  fontWeight: FontWeight.w400,
  fontFamily: FONTFAMILY,
);



