import 'package:open_cx/Screens/Search/PeopleScreen.dart';
import 'package:open_cx/controller/Controller.dart';
import 'package:open_cx/Model/bluetooth/Person.dart';
import 'package:open_cx/Components/GenericContainer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/AppColors.dart' as AppColors;
import 'package:open_cx/Model/bluetooth/Item.dart';
import 'package:flutter/material.dart';

class ItemScreen extends StatelessWidget {
  ItemScreen({this.item});
  final Item item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          title: Text("Item Info"),
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
                GenericContainer(title: "Title", text: item.title),
                Divider(),
                GenericContainer(title: "Type", text: item.type),
                Divider(),
                GenericContainer(
                    title: "Description",
                    text: item.description == ""
                        ? "Not Available"
                        : item.description),
                Divider(),
                GestureDetector(
                  onTap: () async {
                    List<Person> peopleList = await Controller.instance().getPeopleWithKeys(item.authors);

                    Navigator.of(context).push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                        return new PeopleScreen(people:peopleList);
                      }));
                  },
                  child: GenericContainer(
                      title: "Authors", text: item.peopleString, touchable: true),
                ),
                Divider(),
                GenericContainer(
                    title: "Affiliations", text: item.affiliationString),
                Divider(),
                GestureDetector(
                  onTap: () async {
                    if (await canLaunch(item.url)) {
                      await launch(item.url);
                    } else {
                      throw 'Could not launch $item.url';
                    }
                  },
                  child: GenericContainer(
                    title: "URL",
                    text: item.url,
                    touchable: true,
                  ),
                ),
              ],
            )));
  }
}
