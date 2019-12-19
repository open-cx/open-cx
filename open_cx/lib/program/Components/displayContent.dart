import 'package:flutter/material.dart';

import '../Model/Talk.dart';
import '../Screens/Program/TalkPage/TalkPage.dart';

Widget displayContent(Talk talk, BuildContext context) {
  return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute<Null>(builder: (context) => TalkPage(talk: talk)));
          },
          child: Container(
            padding: const EdgeInsets.all(14.0),
            height: 110,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 2, color: talk.getColor()),
                borderRadius: BorderRadius.all(Radius.circular(12)),
                boxShadow: [
                  BoxShadow(
                      color: Color(0x20000000),
                      blurRadius: 5,
                      offset: Offset(0, 3))
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                    talk.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2
                ),
                SizedBox(
                  height: 12,
                ),
                Text(talk.information,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2)
              ],
            ),

          ),
        ),
      )
  );
}