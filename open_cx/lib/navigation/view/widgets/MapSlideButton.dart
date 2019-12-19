import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:open_cx/navigation/constants.dart';

class MapSlideButton extends StatelessWidget {

  MapSlideButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: FlatButton(
        color: Theme.of(context).backgroundColor,
        child: Icon(
          Icons.keyboard_arrow_up,
          color: Colors.white,
          size: 100,
        ),
        onPressed: () {
          FocusScope.of(context).requestFocus(new FocusNode());

          Navigator.pushNamed(context, mapRoute);
        },
      ),
    );
  }

}