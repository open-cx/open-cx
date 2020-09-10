import 'package:flutter/material.dart';
import 'package:communio/view/theme.dart' show navyBlueColor;

class FriendInformation extends StatelessWidget {
  final String name;
  final String location;

  FriendInformation({@required this.name, @required this.location});

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Text(
              name,
              style: Theme.of(context).textTheme.body2,
            ),
          ),
          generateFriendLocation(context, location),
        ]);
  }

  Widget generateFriendLocation(BuildContext context, String location) {
    return Row(children: <Widget>[
      Icon(
        Icons.location_on,
        color: navyBlueColor,
        size: 17,
        // will be color of the theme
      ),
      Padding(
          padding: const EdgeInsets.only(left: 2.0),
          child: Text(
            location,
            style: Theme.of(context).textTheme.body2.apply(fontSizeDelta: -5),
          ))
    ]);
  }
}
