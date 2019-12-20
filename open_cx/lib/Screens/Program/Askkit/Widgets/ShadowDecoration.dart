import 'package:flutter/material.dart';

class ShadowDecoration extends BoxDecoration {
  ShadowDecoration({Color color, Color shadowColor = Colors.black, double blurRadius = 0.0, double spreadRadius = 0.0, Offset offset = const Offset(0,0)}) :
        super(
          color: color,
          boxShadow: [
            BoxShadow(
                color: shadowColor,
                blurRadius: blurRadius,
                spreadRadius: spreadRadius,
                offset: offset
            )
          ]
      );
}
