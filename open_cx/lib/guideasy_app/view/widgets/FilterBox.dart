import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_cx/guideasy_app/model/POIType.dart';
import 'package:open_cx/guideasy_app/view/widgets/FilterItem.dart';

class FilterBox extends StatelessWidget{

    final VoidCallback onChangeFilter;

    FilterBox({Key key, this.onChangeFilter}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return Drawer(
          key: const Key("map filters"),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                height: 88,
                child: DrawerHeader(
                  child: Text('Filters'),
                  margin: EdgeInsets.all(0),
                  decoration: BoxDecoration(
                      color: Color(0xffff9900),
                  ),
                ),
              ),
              FilterItem('Reception', POIType.RECEPTION, onSelected: this.onChangeFilter),
              FilterItem('Lost & Found', POIType.LOST_AND_FOUND, onSelected: this.onChangeFilter),
              FilterItem('Male WC', POIType.MALE_WC, onSelected: this.onChangeFilter),
              FilterItem('Female WC', POIType.FEMALE_WC, onSelected: this.onChangeFilter),
              FilterItem('Accessible WC', POIType.ACCESS_WC, onSelected: this.onChangeFilter),
              FilterItem('Elevators', POIType.ELEVATOR, onSelected: this.onChangeFilter),
              FilterItem('Stairs', POIType.STAIRS, onSelected: this.onChangeFilter),
              FilterItem('Coffee Break', POIType.COFFEE_BREAK, onSelected: this.onChangeFilter),
              FilterItem('Snack Bar', POIType.SNACK_BAR, onSelected: this.onChangeFilter),
              FilterItem('Vending Machine', POIType.VENDING_MACHINE, onSelected: this.onChangeFilter)
            ],
          ),
      );
    }
}