import 'package:flutter/material.dart';

import '../../Components/AccountButton.dart';
import '../../Model/Talk.dart';
import '../../Model/ThemeTalk.dart';
import '../../Model/User.dart';


class PeoplePage extends StatelessWidget {
  final List<Talk> talkList;
  final List<ThemeTalk> allThemes;
  final User user;

  PeoplePage(this.talkList, this.user, this.allThemes);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("People",
          style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Color(0xFF28316C),
        actions: <Widget>[ AccountButton(talkList, user, allThemes) ],
      ),
    );
  }
}