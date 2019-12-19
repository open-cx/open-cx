import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialog {
  BuildContext context;
  List<Widget> actions;
  String title;
  String content;

  CustomDialog({
    this.title = "",
    this.content = "",
    this.actions,
    this.context
  });

  Future<bool> show() {
    return showDialog(
      context: this.context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
            titleTextStyle: Theme.of(context).textTheme.body2,
            contentTextStyle: Theme.of(context).textTheme.body1,
            title: new Text(title),
            content: new Text(content),
            actions: actions
        );
      },
    );
  }
}

class OkDialog extends CustomDialog {
  OkDialog(String title, String content, BuildContext context) : super(
      title: title,
      content: content,
      context: context,
      actions: <Widget>[
        new FlatButton(
          child: new Text("Ok"),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
      ]
  );
}

class ConfirmDialog extends CustomDialog {
  ConfirmDialog({String title, String content, BuildContext context, Function yesPressed, Function noPressed}) : super(
      title: title,
      content: content,
      context: context,
      actions: <Widget>[
        new FlatButton(
          child: new Text("Yes"),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
            yesPressed();
          },
        ),
        new FlatButton(
          child: new Text("No"),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
            noPressed();
          },
        ),
      ]
  );
}
