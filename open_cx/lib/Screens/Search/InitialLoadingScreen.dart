import 'dart:io';

import 'package:open_cx/controller/Controller.dart';
import 'package:open_cx/Components/GenericContainer.dart';
import 'package:flutter/material.dart';
import '../../constants/AppColors.dart' as AppColors;
import '../../constants/Utility.dart' as Utility;

class InitialLoadingScreen extends StatefulWidget {
  @override
  State<InitialLoadingScreen> createState() {
    return InitialLoadingScreenState();
  }
}

class InitialLoadingScreenState extends State<InitialLoadingScreen> {
  @override
  void initState() {
    super.initState();
    Controller.instance().initDatabase().then((success) {
        if(success) {
          Navigator.of(context).pushReplacementNamed('/agendAppMain');
        }
        else
          _noInternetAlert(context);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundColor,
      child: Column(
        children: <Widget> [
          Padding(
            padding: const EdgeInsets.only(left: 50.0, right: 50.0, top: 200.0, bottom: 50.0),
            child: GenericContainer(
              title: "Welcome to AgendApp",
              text: "Please wait...",
            ),
          ),
          Image(image: AssetImage("assets/images/AMA.gif"))
      ]),
    );
  }


  void _noInternetAlert(BuildContext context) {
        showDialog(context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(Utility.noInternetTitle),
                content: Text(Utility.noInternetText),
                actions: <Widget>[
                  FlatButton(
                    child: Text("OK"),
                    onPressed: () => exit(0),
                  )
                ],
              );
            }
        );
    }
}
