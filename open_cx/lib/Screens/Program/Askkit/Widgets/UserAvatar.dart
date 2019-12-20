import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../Model/User.dart';
import '../Controllers/ModelListener.dart';


class UserAvatar extends StatelessWidget implements ModelListener {
  final double avatarRadius;
  final User user;
  final TextStyle textStyle;
  bool anonymous;

  UserAvatar(this.user,  {this.anonymous, this.avatarRadius = 10.0, this.textStyle});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
            child: new CircleAvatar(
                radius: avatarRadius,
                backgroundImage: anonymous ? null : user.getImage()
            ),
            padding: EdgeInsets.all(1.0),
            margin: EdgeInsets.only(right: avatarRadius / 2),
            decoration: new BoxDecoration(
              color: Theme.of(context).iconTheme.color, // border color
              shape: BoxShape.circle,
            )
        ),
        Text(anonymous ? 'Anonymous' : user.name, style: textStyle)
      ],
    );
  }

  @override
  void refreshModel(bool showIndicator) {
    // TODO: implement refreshModel
  }

}