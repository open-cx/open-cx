import 'package:open_cx/Model/bluetooth/Person.dart';
import 'package:open_cx/Components/GenericContainer.dart';
import 'package:flutter/material.dart';
import 'package:open_cx/Screens/Search/PersonScreen.dart';
import '../../constants/AppColors.dart' as AppColors;

class PeopleScreen extends StatelessWidget {
  PeopleScreen({this.people});

  final List<Person> people;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          title: Text("Pessoal"),
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
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: people.length,
                itemBuilder: (context, idx) {
                  return GestureDetector(
                      onTap: () async {
                       Navigator.of(context).push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                        return new PersonScreen(person:this.people.elementAt(idx));
                      }));
                      },
                      child: Padding(
                          padding: EdgeInsets.all(10),
                          child: GenericContainer(
                              title: people.elementAt(idx).name,
                              text: people.elementAt(idx).affiliation, touchable: true,)));
                })));
  }
}
