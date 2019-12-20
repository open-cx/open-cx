import 'package:open_cx/networking/view/Pages/general_page_view.dart';
import 'package:flutter/material.dart';

class SettingsPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GeneralPageView(
      child: ListView(
        children: this.buildSettings(context),
      ),
    );
  }

  List<Widget> buildSettings(BuildContext context) {
    return [
      FlatButton(
        child: Text('Choose beacon',
          style: Theme.of(context).textTheme.body2,),
        onPressed: () {
          
          Navigator.of(context).pushNamed('/SetBeacon');
        },
      )
    ];
  }
}