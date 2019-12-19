import 'package:flutter/material.dart';

import '../Controllers/ModelListener.dart';

abstract class CardTemplate extends StatelessWidget {



  static TextStyle usernameStyle(BuildContext context, bool highlight) {
    if (highlight)
      return Theme.of(context).textTheme.body2.copyWith(fontSize: 20.0, color: Theme.of(context).primaryColor);
    return Theme.of(context).textTheme.body2.copyWith(fontSize: 20.0);
  }

  static Color shadowColor(BuildContext context) => Theme.of(context).dividerColor;
  static TextStyle dateStyle(BuildContext context) => TextStyle(fontSize: 10.0);
  static TextStyle editedStyle(BuildContext context) => TextStyle(fontSize: 8.0);

  static const EdgeInsets contentPadding = EdgeInsets.only(top: 10.0);

  final ModelListener listener;

  CardTemplate(this.listener);

  Widget buildCardContent(BuildContext context);

  onClick(BuildContext context);

  onHold(BuildContext context);

  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        highlightColor: Theme.of(context).primaryColorLight,
        onLongPress: () => onHold(context),
        onTap: () => onClick(context),
        child: Container(
            padding: EdgeInsets.all(10.0),
            child: buildCardContent(context)
        ),
      ),
      color: Theme.of(context).canvasColor,
    );
  }
}