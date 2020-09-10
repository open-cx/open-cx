
import 'package:flutter/material.dart';

Widget displayTime(String initialTime, String finalTime) {
  return Container(
      padding: const EdgeInsets.only(left: 13.0, right: 10.0, bottom: 10),
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000))),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(initialTime),
            SizedBox(
              height: 12,
            ),
            Text(finalTime)
          ]));
}