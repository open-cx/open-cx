import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_cx/navigation/model/POIType.dart';
import 'package:open_cx/navigation/view/widgets/HomePageButton.dart';
import 'package:open_cx/navigation/view/widgets/MapSlideButton.dart';
import 'package:open_cx/navigation/view/widgets/RoomSearchBar.dart';

class HomePage extends StatelessWidget {

  HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      key: const Key("Home page"),
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color(0xffff9900),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
            child: Text(
              'Guideasy',
              style: theme.textTheme.headline,
            )
        ),
        backgroundColor: Color(0xffff9900),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                'Take me to...',
                style: theme.textTheme.display1,
              ),
            ),
          ),
          Expanded(
              flex: 2,
              child: Container(
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 0),
                  child: RoomSearchBar())
          ),
          Expanded(
            flex: 7,
            child: GridView.count(
              primary: false,
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 0),
              crossAxisSpacing: 20,
              mainAxisSpacing: 30,
              crossAxisCount: 3,
              children: <Widget>[
                HomePageButton(POIType.MALE_WC),
                HomePageButton(POIType.ACCESS_WC),
                HomePageButton(POIType.FEMALE_WC),
                HomePageButton(POIType.ELEVATOR),
                HomePageButton(POIType.COFFEE_BREAK, key: const Key("nearest poi button")),
                HomePageButton(POIType.VENDING_MACHINE),
                HomePageButton(POIType.LOST_AND_FOUND),
                HomePageButton(POIType.ROOM),
                HomePageButton(POIType.RECEPTION),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Tooltip(
              message: "Open event map",
              child: MapSlideButton(key: const Key("map slide button"))
            ),
          )
        ],
      ),
    );
  }
}