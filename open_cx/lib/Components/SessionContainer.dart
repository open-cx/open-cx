import 'package:open_cx/Model/bluetooth/Session.dart';
import 'package:flutter/material.dart';
import 'package:open_cx/Screens/Search/SessionScreen.dart';
import '../constants/AppColors.dart' as AppColors;

class SessionContainer extends StatelessWidget {
  SessionContainer({this.activity});

  final Session activity;

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return FlatButton(
        padding: const EdgeInsets.all(0.0),
        onPressed: () {
         Navigator.of(context).push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                        return new SessionScreen(session:this.activity);
                      }));
        },
        child: activity.isCustom == 1
            ? this.drawCustomSessionContainer(deviceWidth)
            : this.drawNormalSessionContainer(deviceWidth));
  }

  Widget drawNormalSessionContainer(double deviceWidth) {
    return ConstrainedBox(
        constraints: BoxConstraints(minHeight: 150),
        child: Container(
            width: deviceWidth * 0.95,
            decoration: BoxDecoration(
                color: AppColors.containerColor,
                borderRadius: BorderRadius.all(Radius.circular(18.0))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                this.drawTitle(),
                Row(
                  children: <Widget>[
                    this.drawType(),
                    this.drawDay(),
                  ],
                ),
                Row(
                  children: <Widget>[
                    this.drawLocation(),
                    this.drawTime(),
                  ],
                )
              ],
            )));
  }

  Widget drawCustomSessionContainer(double deviceWidth) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 150),
      child: Container(
        width: deviceWidth * 0.95,
        decoration: BoxDecoration(
            color: AppColors.customSessionContainerColor,
            borderRadius: BorderRadius.all(Radius.circular(18.0))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            this.drawTitle(),
            Row(
              children: <Widget>[
                this.drawLocationCustom(deviceWidth),
                this.drawDay(),
              ],
            ),
            Row(
              children: <Widget>[
                this.getDescription(deviceWidth),
                this.drawTime(),
              ],
            )
          ],
        ),
      ),
    );
  }


  Widget getDescription(double deviceWidth) {
    Text text;

    if (this.activity.description == "") {
      text = Text(
        "No description available",
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.justify,
        style: TextStyle(color: Colors.black38),
      );
    } else
      text = Text(
        this.activity.description,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      );

    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text("Description: ",
                style: TextStyle(color: AppColors.mainColor, fontSize: 17)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
                  width: deviceWidth * 0.45,
                  child: text),
          ),
        ],
      ),
    );
  }

  Widget drawTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
      child: Text(
        activity.title,
        key: Key("Session title"),
        style: TextStyle(
          color: AppColors.mainColor,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget drawType() {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: RichText(
          text: TextSpan(
              style: TextStyle(color: AppColors.mainColor, fontSize: 17),
              children: <TextSpan>[
                TextSpan(
                    text: "Type: ",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: activity.type)
              ]),
        ),
      ),
    );
  }

  Widget drawDay() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Text(
        activity.day,
        style: TextStyle(color: Colors.grey, fontSize: 17),
        textAlign: TextAlign.right,
      ),
    );
  }

  Widget drawLocation() {
    return Expanded(
      flex: 6,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
        child: RichText(
          text: TextSpan(
              style: TextStyle(color: AppColors.mainColor, fontSize: 17),
              children: <TextSpan>[
                TextSpan(
                    text: "Location: ",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: activity.location)
              ]),
        ),
      ),
    );
  }

  Widget drawLocationCustom(double deviceWidth) {
    Text locationText;

    if (this.activity.location != "") {
      locationText = Text(
        this.activity.location,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    } else {
      locationText = Text(
        "No location available",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.justify,
        style: TextStyle(color: Colors.black38),
      );
    }

    return Expanded(
      flex: 6,
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text("Location: ",
                  style: TextStyle(color: AppColors.mainColor, fontSize: 17)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: Container(
                  width: deviceWidth * 0.45,
                  child: locationText),
            ),
          ],
        ),
      ),
    );

  }

  Widget drawTime() {
    return Expanded(
      flex: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 15.0),
        child: Text(
          activity.timeString,
          style: TextStyle(
              color: AppColors.mainColor,
              fontSize: 17,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.right,
        ),
      ),
    );
  }
}
