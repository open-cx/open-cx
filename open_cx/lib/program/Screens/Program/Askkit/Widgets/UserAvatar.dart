import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../Model/User.dart';


class UserAvatar extends StatelessWidget {
  final double avatarRadius;
  final User user;
  final TextStyle textStyle;

  static final ImageProvider anonymousImage = NetworkImage('https://cdn4.iconfinder.com/data/icons/political-elections/50/48-512.png');
  bool anonymous;

  UserAvatar(this.user,  {this.anonymous, this.avatarRadius = 10.0, this.textStyle});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
            child: new CircleAvatar(
                backgroundColor: Colors.white,
                radius: avatarRadius,
                backgroundImage: anonymous ? anonymousImage : user.getImage()
            ),
            padding: EdgeInsets.all(1.0),
            margin: EdgeInsets.only(right: avatarRadius / 2),
            decoration: new BoxDecoration(
              color: Theme.of(context).iconTheme.color, // border color
              shape: BoxShape.circle,
            ),
        ),
        Text(anonymous ? 'Anonymous' : user.name, style: textStyle)
      ],
    );
  }

}