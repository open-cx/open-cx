import 'package:open_cx/networking/model/known_person.dart';
import 'package:open_cx/networking/model/social_block.dart';
import 'package:open_cx/networking/view/theme.dart';
import 'package:flutter/material.dart';

class SocialMediaColumn extends StatefulWidget {
  final KnownPerson person;
  final bool edit;

  SocialMediaColumn({@required this.person, @required this.edit});

  @override
  _SocialMediaColumnState createState() =>
      _SocialMediaColumnState(person, edit);
}

class _SocialMediaColumnState extends State<SocialMediaColumn> {
  final KnownPerson person;
  final bool edit;
  _SocialMediaColumnState(this.person, this.edit);

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context).size;
    return Column(
      children: this.buildMediaRows(context, query),
    );
  }

  buildMediaRows(BuildContext context, Size query) {
    final List<Widget> children = List();
    person.socials.forEach((socialMedia) {
      children.add(Container(
          width: query.width * 0.75,
          margin: EdgeInsets.only(
              top: query.height * 0.005, bottom: query.height * 0.002),
          child: buildExternalRow(context, query, socialMedia)));
    });
    return children;
  }

  buildExternalRow(BuildContext context, Size query, SocialBlock socialMedia) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: buildRowsList(context, query, socialMedia));
  }

  buildRowsList(BuildContext context, Size query, SocialBlock socialMedia) {
    final List<Widget> children = List();
    children.add(
      Container(
          width: query.width * 0.61,
          color: Theme.of(context).colorScheme.primaryVariant,
          child: buildInternalRow(context, query, socialMedia)),
    );

    if (edit) {
      children.add(IconButton(
        icon: Icon(
          Icons.delete,
          color: grayColor,
        ),
        onPressed: () {
          // TO-DO delete from Server
          setState(() {
            person.socials.remove(socialMedia);
          });
        },
      ));
    }
    return children;
  }

  buildInternalRow(BuildContext context, Size query, SocialBlock socialMedia) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        new Transform(
            alignment: Alignment.center,
            transform: new Matrix4.identity()..scale(0.9, 0.9),
            child: Container(
              margin: EdgeInsets.only(
                  top: query.height * 0.01, bottom: query.height * 0.01),
              child: socialMedia.logo,
            )),
        Container(
            width: query.width * 0.3,
            child: Text(
              socialMedia.url,
              style: Theme.of(context).textTheme.body1.apply(fontSizeDelta: -7),
              overflow: TextOverflow.ellipsis,
              softWrap: false,
            )),
        Container(
            width: query.width * 0.1,
            child: Text(
              socialMedia.name[0].toUpperCase() + socialMedia.name.substring(1),
              style:
                  Theme.of(context).textTheme.body1.apply(fontSizeDelta: -10),
            )),
      ],
    );
  }
}
