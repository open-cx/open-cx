import 'package:open_cx/Model/bluetooth/Item.dart';
import 'package:open_cx/Components/GenericContainer.dart';
import 'package:flutter/material.dart';
import 'package:open_cx/Screens/Search/ItemScreen.dart';
import '../../constants/AppColors.dart' as AppColors;

class ItemsScreen extends StatelessWidget {
  ItemsScreen({this.items});

  final List<Item> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          title: Text("Items"),
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
                itemCount: items.length,
                itemBuilder: (context, idx) {
                  return GestureDetector(
                      onTap: () async {
                        Navigator.of(context).push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                        return new ItemScreen(item:items.elementAt(idx));
                      }));
                      },
                  child: Padding(
                      padding: EdgeInsets.all(10),
                      child: GenericContainer(
                          title: items.elementAt(idx).title,
                          text: items.elementAt(idx).peopleString,
                          touchable: true)
                  )
                  );
                }
                )
        )
    );
  }
}
