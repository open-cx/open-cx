import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Model/Talk.dart';
import '../Model/ThemeTalk.dart';
import '../Model/User.dart';
import '../Screens/Account/Account_Screen.dart';

class AccountButton extends StatelessWidget {
  final List<Talk> talkList;
  final List<ThemeTalk> allThemes;
  final User user;

  AccountButton(this.talkList, this.user, this.allThemes);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AccountPage(talkList: talkList, themesList: allThemes, user: user))),
        child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(7.5),
            padding: EdgeInsets.all(1.0),
            child: CircleAvatar(radius: 20, backgroundImage: NetworkImage(user.photo)),
            decoration: new BoxDecoration(color: Colors.black, shape: BoxShape.circle)
        )
    );
  }

}