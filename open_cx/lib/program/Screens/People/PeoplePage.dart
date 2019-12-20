import 'package:flutter/material.dart';
import 'package:open_cx/networking/main.dart';

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
    return Communio();
  }
}