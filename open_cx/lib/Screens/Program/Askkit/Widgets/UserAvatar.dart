import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../Model/User.dart';


class UserAvatar extends StatelessWidget {
  final double avatarRadius;
  final User user;
  final TextStyle textStyle;

  UserAvatar(this.user, {this.avatarRadius = 10.0, this.textStyle});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
            child: new CircleAvatar(
                radius: avatarRadius,
                backgroundImage:  user.getImage()
            ),
            padding: EdgeInsets.all(1.0),
            margin: EdgeInsets.only(right: avatarRadius / 2),
            decoration: new BoxDecoration(
              color: Theme.of(context).iconTheme.color, // border color
              shape: BoxShape.circle,
            )
        ),
        Text(user.name, style: textStyle)
      ],
    );
  }

}