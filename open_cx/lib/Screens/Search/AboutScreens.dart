import 'package:open_cx/Components/GenericContainer.dart';
import 'package:open_cx/Components/GenericTitle.dart';
import 'package:flutter/material.dart';
import '../../constants/AppColors.dart' as AppColors;
import '../../constants/Utility.dart' as Utility;

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "About",
            style: TextStyle(color: Colors.white),
            key: Key("Screen title"),
          ),
          backgroundColor: AppColors.mainColor,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Container(
          color: AppColors.backgroundColor,
          child: ListView(
            padding: EdgeInsets.only(bottom: 10.0),
            children: <Widget>[
              getAboutMessageContainer(),
              getTeamTitle(),
              getTeamContainer(context),
            ],
          ),
        ));
  }

  Widget getAboutMessageContainer() {
    return Padding(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 15.0),
      child: GenericContainer(
        title: "AMA - Agenda Mobile App",
        text: Utility.aboutText,
      ),
    );
  }

  Widget getTeamTitle() {
    return Center(
      child: GenericTitle(
          title: "The Team:",
          padding: EdgeInsets.all(6.0),
          margin: EdgeInsets.only(top: 10.0),
          style: TextStyle(
              color: AppColors.mainColor,
              fontWeight: FontWeight.w900,
              fontSize: 25)),
    );
  }

  Widget getTeamContainer(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
      child: Column(
        children: <Widget>[
          getTeamElement("Professor Ademar Aguiar", true, Utility.ademarPhoto),
          Divider(height: 6),
          getTeamElement("David Silva", false, Utility.davidPhoto),
          Divider(height: 6),
          getTeamElement("Eduardo Ribeiro", true, Utility.eduPhoto),
          Divider(height: 6),
          getTeamElement("José Gomes", false, Utility.zePhoto),
          Divider(height: 6),
          getTeamElement("Luís Cunha", true, Utility.luisPhoto),
        ],
      ),
    );
  }

  Widget getTeamElement(String name, bool toTheRight, String imageAddr) {
    CircleAvatar photo = CircleAvatar(
      radius: 30.0,
      backgroundImage: NetworkImage(imageAddr),
      backgroundColor: Colors.transparent,
    );

    if (toTheRight) {
      return Container(
          decoration: new BoxDecoration(
              color: AppColors.containerColor,
              borderRadius: BorderRadius.circular(10.0)),
          child: ListTile(
            contentPadding:
                EdgeInsets.only(top: 6.0, right: 15.0, bottom: 6.0, left: 15.0),
            title: Text(
              name,
              textAlign: TextAlign.right,
            ),
            leading: photo,
          ));
    } else {
      return Container(
          decoration: new BoxDecoration(
              color: AppColors.containerColor,
              borderRadius: BorderRadius.circular(10.0)),
          child: ListTile(
            contentPadding:
                EdgeInsets.only(top: 6.0, right: 15.0, bottom: 6.0, left: 15.0),
            title: Text(
              name,
              textAlign: TextAlign.left,
            ),
            trailing: photo,
          ));
    }
  }
}


// ------------------


class SessionScanAboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "About Session Scanning",
            style: TextStyle(color: Colors.white),
            key: Key("Screen title"),
          ),
          backgroundColor: AppColors.mainColor,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Container(
          color: AppColors.backgroundColor,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 15.0),
                child: GenericContainer(
                  title: "How does session scanning work?",
                  text: Utility.sessionSearchAboutText,
                ),
              ),
            ],
          ),
        ));
  }
}
