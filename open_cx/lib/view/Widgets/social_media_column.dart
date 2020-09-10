import 'package:communio/model/known_person.dart';
import 'package:communio/model/social_block.dart';
import 'package:communio/view/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class SocialMediaColumn extends StatefulWidget {
  final KnownPerson person;
  final bool edit;
  final Function(String, String) adding;
  final Function(String) removing;

  SocialMediaColumn(
      {@required this.person,
      @required this.edit,
      @required this.adding,
      @required this.removing});

  @override
  _SocialMediaColumnState createState() =>
      _SocialMediaColumnState(person, edit, adding, removing);
}

class _SocialMediaColumnState extends State<SocialMediaColumn> {
  final KnownPerson person;
  final bool edit;
  final Function(String, String) adding;
  final Function(String) removing;

  _SocialMediaColumnState(this.person, this.edit, this.adding, this.removing);

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context).size;
    return Column(
      children: this.buildMediaRows(context, query),
    );
  }

  buildMediaRows(BuildContext context, Size query) {
    final List<Widget> children = List();

    final List<String> socialList = SocialBlock.socialLogo.keys.toList()
      ..removeWhere((key) =>
          person.socials
                  .indexWhere((personSocial) => personSocial.name == key) !=
              -1 ||
          key == "default");
    person.socials.asMap().forEach((index, socialMedia) {
      children.add(Container(
          key: Key('social-block-$index'),
          width: query.width * 0.75,
          margin: EdgeInsets.only(
              top: query.height * 0.005, bottom: query.height * 0.002),
          child: buildExternalRow(context, query, socialMedia)));
    });

    if (socialList.isNotEmpty) {
      children.add(Container(
          width: query.width * 0.75,
          margin: EdgeInsets.only(
              top: query.height * 0.005, bottom: query.height * 0.002),
          child: buildAddingSocial(context, query, person, socialList)));
    }

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
        key: Key(socialMedia.name),
        icon: Icon(
          Icons.delete,
          color: grayColor,
        ),
        onPressed: () {
          if (removing != null) {
            removing(socialMedia.name);
          }
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
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        new Transform(
            alignment: Alignment.center,
            transform: new Matrix4.identity()..scale(0.7, 0.7),
            child: Container(
              margin: EdgeInsets.only(
                  top: query.height * 0.0, bottom: query.height * 0.0),
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
            width: query.width * 0.15,
            child: Text(
              socialMedia.name[0].toUpperCase() + socialMedia.name.substring(1),
              style:
                  Theme.of(context).textTheme.body1.apply(fontSizeDelta: -10),
            )),
      ],
    );
  }

  buildAddingSocial(BuildContext context, Size query, KnownPerson person,
      List<String> remainingSocials) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new SocialMediaForm(
            callback: addSocial,
            query: query,
            remainingSocials: remainingSocials),
      ],
    );
  }

  addSocial(String socialID, String newSocial) async {
    if (adding != null) adding(socialID, newSocial);
    setState(() {
      person.socials.add(new SocialBlock(socialID, newSocial));
    });
  }
}

class SocialMediaForm extends StatefulWidget {
  final Function(String, String) callback;
  final List<String> remainingSocials;
  final Size query;

  const SocialMediaForm(
      {Key key,
      @required this.callback,
      @required this.query,
      @required this.remainingSocials})
      : super(key: key);

  @override
  _SocialMediaFormState createState() =>
      _SocialMediaFormState(callback, query, remainingSocials);
}

class _SocialMediaFormState extends State<SocialMediaForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController fieldController = TextEditingController();
  final List<String> remainingSocials;
  final Size query;
  int index = 0;

  final Function(String, String) callback;

  _SocialMediaFormState(this.callback, this.query, this.remainingSocials);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Form(
          key: _formKey,
          child: Container(
            width: query.width * 0.61,
            color: Theme.of(context).colorScheme.primaryVariant,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Transform(
                    alignment: Alignment.center,
                    transform: new Matrix4.identity()..scale(0.7, 0.7),
                    child: Container(
                      margin: EdgeInsets.only(
                          top: query.height * 0.0, bottom: query.height * 0.0),
                      child: SocialBlock.socialLogo['default'],
                    )),
                buildTextField(context),
                new Container(
                  alignment: Alignment.center,
                  child: buildSocialDropdown(context, remainingSocials),
                )
              ],
            ),
          ),
        ),
        buildAddButton(context),
      ],
    );
  }

  buildTextField(BuildContext context) {
    return Container(
      width: query.width * 0.3,
      child: TextFormField(
        style: Theme.of(context).textTheme.body1.apply(fontSizeDelta: -7),
        controller: fieldController,
      ),
    );
  }

  buildAddButton(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
            color: Theme.of(context).colorScheme.primary,
            icon: Icon(Icons.add),
            onPressed: () {
              if (_formKey.currentState.validate() &&
                  fieldController.text.isNotEmpty) {
                callback(remainingSocials[index], fieldController.text);
              }
              fieldController.clear();
            },
          )
        ]);
  }

  buildSocialDropdown(BuildContext context, List<String> remainingSocials) {
    String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

    final List<String> printableSocials =
        remainingSocials.map((social) => capitalize(social)).toList();

    return DropdownButton<String>(
      value: printableSocials[index],
      iconSize: 0,
      elevation: 0,
      style: Theme.of(context).textTheme.body1.apply(fontSizeDelta: -10),
      underline: Container(
        height: 0,
      ),
      onChanged: (String newValue) {
        setState(() {
          index = printableSocials.indexOf(newValue);
        });
      },
      items: printableSocials.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
