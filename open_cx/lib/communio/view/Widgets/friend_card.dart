import 'package:open_cx/communio/model/known_person.dart';
import 'package:open_cx/communio/view/Pages/profile_page.dart';
import 'package:open_cx/communio/view/Widgets/friend_information.dart';
import 'package:open_cx/communio/view/Widgets/photo_avatar.dart';
import 'package:open_cx/communio/view/theme.dart';
import 'package:flutter/material.dart';

class FriendCard extends StatefulWidget {
  final KnownPerson friend;

  const FriendCard({Key key, @required this.friend}) : super(key: key);

  @override
  _FriendCardState createState() => _FriendCardState(friend);
}

class _FriendCardState extends State<FriendCard> {
  final KnownPerson friend;
  bool opened = false;

  _FriendCardState(this.friend);

  @override
  Widget build(BuildContext context) {
    return new Card(
        margin: EdgeInsets.all(0.0),
        shape: ContinuousRectangleBorder(),
        child: Column(children: <Widget>[
          generateFriendMainCard(friend),
          generateFriendSocialsContainer(friend)
        ]));
  }

  Widget generateFriendSocialsContainer(KnownPerson friend) {
    return this.opened
        ? Container(
            alignment: Alignment.center,
            color: lighterCyanColor,
            height: 80.0,
            child: new ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: generateFriendSocials(this.friend)))
        : Container();
  }

  List<Widget> generateFriendSocials(KnownPerson friend) {
    final List<Widget> children = new List<Widget>();
    for (var social in friend.socials) {
      children.add(new Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: social.logo));
    }
    return children;
  }

  Widget generateFriendInfo(KnownPerson friend) {
    return Row(
      children: <Widget>[
        MaterialButton(
            padding: EdgeInsets.all(0.0),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfilePage(
                            knownPerson: friend,
                            edit: false,
                          )));
            },
            child: PhotoAvatar(photo: friend.photo)),
        Padding(
          padding: const EdgeInsets.only(left: 13.0, top: 13.0, bottom: 13.0),
          child:
              FriendInformation(name: friend.name, location: friend.location),
        ),
      ],
    );
  }

  Widget generateFriendMainCard(KnownPerson friend) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 17.0, top: 7.5, bottom: 7.5, right: 17.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            generateFriendInfo(friend),
            IconButton(
                onPressed: () {
                  setState(() {
                    this.opened = !this.opened;
                  });
                },
                icon: Icon(
                  this.opened
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  size: 30.0,
                  color: navyBlueColor,
                ))
          ]),
    );
  }
}
