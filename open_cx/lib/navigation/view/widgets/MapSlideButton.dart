import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:open_cx/navigation/constants.dart';

class MapSlideButton extends StatelessWidget {

  MapSlideButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: FlatButton(
        color: Theme.of(context).primaryColor,
        child: Icon(
          Icons.zoom_out_map,
          color: Colors.white,
          size: 45,
        ),
        onPressed: () {
          FocusScope.of(context).requestFocus(new FocusNode());

          Navigator.pushNamed(context, mapRoute);
        },
      ),
    );
  }

}