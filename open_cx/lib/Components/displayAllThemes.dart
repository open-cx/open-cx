import 'package:flutter/material.dart';

import '../Model/ThemeTalk.dart';

Widget displayAllThemes(List<ThemeTalk> themes) {
  return Container(
    padding: const EdgeInsets.only(bottom: 20, top: 20),
    child: Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 10,
            runSpacing: 10,
            children: <Widget>[
              for(int i = 0; i < themes.length; i++)
                displayThemeTalk(themes[i]),

            ],

          ));
}

Widget displayThemeTalk(ThemeTalk theme) {
  return Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 2, color: theme.color),
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: [
              BoxShadow(
                  color: Color(0x20000000), blurRadius: 5, offset: Offset(0, 3))
            ]),
        child: Text(theme.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: theme.color,
            )),
      );
}