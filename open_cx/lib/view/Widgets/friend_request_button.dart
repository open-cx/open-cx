import 'dart:convert';
import 'dart:io';

import 'package:communio/model/friend_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class FriendRequestButton extends StatefulWidget {
  final FriendRequest friendRequest;

  FriendRequestButton({@required this.friendRequest});

  @override
  _FriendRequestButtonState createState() =>
      _FriendRequestButtonState(this.friendRequest);
}

class _FriendRequestButtonState extends State<FriendRequestButton> {
  final FriendRequest friendRequest;
  bool accepted = null;
  _FriendRequestButtonState(this.friendRequest);

  @override
  Widget build(BuildContext context) {
    if (accepted == null) {
      return getIconRow(context);
    }
    if (accepted) {
      return Text(
        'Added!',
        style: Theme.of(context).textTheme.body1.apply(fontSizeDelta: -5),
      );
    }
    return Text('Rejected!',
        style: Theme.of(context).textTheme.body1.apply(fontSizeDelta: -5));
  }

  Row getIconRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildIcon(
            key: Key('${friendRequest.id}-accept'),
            child: Icon(
              Icons.check,
              color: Colors.white,
            ),
            onPressed: () async {
              final map = {"id": friendRequest.id};
              await http.post('${DotEnv().env['API_URL']}users/matches/accept',
                  body: json.encode(map),
                  headers: {
                    HttpHeaders.contentTypeHeader: 'application/json',
                  });
              setState(() {
                accepted = true;
              });
            },
            fillColor: Theme.of(context).colorScheme.primary),
        buildIcon(
            key: Key('${friendRequest.id}-reject'),
            child: Icon(
              Icons.clear,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () async {
              final map = {"id": friendRequest.id};
              await http.post('${DotEnv().env['API_URL']}users/matches/reject',
                  body: json.encode(map),
                  headers: {
                    HttpHeaders.contentTypeHeader: 'application/json',
                  });
              setState(() {
                accepted = false;
              });
            },
            fillColor: Theme.of(context).colorScheme.onBackground),
      ],
    );
  }

  buildIcon(
      {Key key, @required child, @required onPressed, @required fillColor}) {
    final size = MediaQuery.of(context).size;
    return Container(
      key: key,
      margin: EdgeInsets.only(right: size.width * 0.03),
      child: SizedBox(
          width: size.width * 0.08,
          height: size.width * 0.08,
          child: RawMaterialButton(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  side: BorderSide(
                      color: Theme.of(context).colorScheme.background)),
              child: child,
              fillColor: fillColor,
              padding: EdgeInsets.all(0),
              onPressed: onPressed)),
    );
  }
}
