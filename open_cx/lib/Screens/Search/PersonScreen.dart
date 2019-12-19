import 'package:open_cx/Model/bluetooth/Person.dart';
import 'package:open_cx/Components/GenericContainer.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/AppColors.dart' as AppColors;

class PersonScreen extends StatelessWidget {
  final Person person;

  PersonScreen({this.person});

  @override
  Widget build(BuildContext context) {
    print(person.imageURL);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Text("Personal Information"),
        leading: IconButton(
          key: Key("Back button"),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
          child: ListView(
        padding: const EdgeInsets.all(10),
        children: <Widget>[
          Center(child: printAvatar()),
          Center(
              child: Text(
            person.name + "\n" + person.affiliation,
            key: Key("Person Identification"),
            style: TextStyle(
                color: AppColors.mainColor,
                fontWeight: FontWeight.w900,
                fontSize: 25),
            textAlign: TextAlign.center,
          )),
          Divider(),
          GenericContainer(
            title: "Biography",
            text: person.bio == null ? "Not Available" : person.bio,
          ),
          Divider(),
          GestureDetector(
            onTap: () async {
              if(person.url != null)
              if (await canLaunch(person.url)) {
                await launch(person.url);
              } else {
                throw 'Could not launch $person.url';
              }
            },
            child: GenericContainer(
              title: "URL",
              text: person.url == null ? "Not Available" : person.url,
              touchable: true,
            ),
          ),
        ],
      )),
    );
  }

  printAvatar() {
    if (person.imageURL != null)
      return CircleAvatar(
        radius: 100,
        backgroundImage: NetworkImage(person.imageURL),
      );
    else {
      return CircleAvatar(
          radius: 100,
          child: Text(
            getInitials(person.name),
            style: TextStyle(fontSize: 40),
          ));
    }
  }

  String getInitials(String text) {
    if (text.length <= 1) return text.toUpperCase();
    var words = text.split(' ');
    var capitalized = words.map((word) {
      var first = word.substring(0, 1).toUpperCase();
      return '$first';
    });
    return capitalized.join(' ');
  }
}
