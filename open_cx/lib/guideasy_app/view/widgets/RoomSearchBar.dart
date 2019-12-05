import 'dart:async';
import 'dart:async';
import 'dart:core';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:geolocator/geolocator.dart';
import 'package:open_cx/guideasy_app/constants.dart';
import 'package:open_cx/guideasy_app/controller/map_navigation/MapPosition.dart';
import 'package:open_cx/guideasy_app/model/AppState.dart';
import 'package:open_cx/guideasy_app/model/MapPageArguments.dart';
import 'package:open_cx/guideasy_app/model/POIType.dart';
import 'package:open_cx/guideasy_app/model/PointOfInterest.dart';
import 'package:open_cx/guideasy_app/redux/Actions.dart';

class RoomSearchBar extends StatefulWidget {
  @override
  _RoomSearchBarState createState() => _RoomSearchBarState();
}

class _RoomSearchBarState extends State<RoomSearchBar> {

  AutoCompleteTextField searchTextField;
  TextEditingController controller = new TextEditingController();
  GlobalKey<AutoCompleteTextFieldState<PointOfInterest>> key = new GlobalKey();

  _RoomSearchBarState();
  MapPosition _gpsPosition;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    getCurrentPosition().then((Position pos) {
      _gpsPosition = pos == null ? null : MapPosition(pos.latitude, pos.longitude);
    });

    return StoreConnector<AppState, List<PointOfInterest>>(
        converter: (store) => store.state.content['pointsOfInterest'],
        builder: (BuildContext context, List<PointOfInterest> pointsOfInterest) {
          searchTextField = AutoCompleteTextField<PointOfInterest>(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(0),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                border: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.white,
                        width: 1
                    )
                ),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.white,
                        width: 1
                    )
                ),
                labelStyle: Theme
                    .of(context)
                    .textTheme
                    .body2,
                labelText: 'Search room',
              ),
              style: Theme
                  .of(context)
                  .textTheme
                  .body2,
              clearOnSubmit: true,
              itemBuilder: (context, item) {

                String distance = "?";
                if (_gpsPosition != null) {
                  MapPosition poiPos = MapPosition(item.latitude, item.longitude);
                  distance = _gpsPosition.distanceTo(poiPos).round().toString() + "m";
                }

                return Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  constraints: BoxConstraints(
                      minWidth: 100.0,
                      minHeight: 70.0
                  ),
                  decoration: BoxDecoration(
                      color: Colors.orangeAccent,
                      border: Border.all(
                          color: Colors.orange,
                          width: 2
                      )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Text(item.title,
                          style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.white
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(distance,
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white
                          ),
                          textAlign: TextAlign.right,),
                      ),
                    ],
                  ),
                );
              },
              itemFilter: (item, query) {
                bool q1 = item.title
                    .toLowerCase()
                    .startsWith(query.toLowerCase());
                bool q2 = item.title
                    .toLowerCase()
                    .contains(query.toLowerCase());
                bool q3 = item.keyword
                    .toLowerCase()
                    .startsWith(query.toLowerCase());
                bool q4 = item.keyword
                    .toLowerCase()
                    .contains(query.toLowerCase());
                return q1 || q2 || q3 || q4;
              },
              itemSorter: (a, b) {
                if (_gpsPosition == null) return a.title.compareTo(b.title);
                
                int dist1 = _gpsPosition.distanceTo(MapPosition(a.latitude, a.longitude)).round();
                int dist2 = _gpsPosition.distanceTo(MapPosition(b.latitude, b.longitude)).round();
                return dist1.compareTo(dist2);
              },
              key: key,
              itemSubmitted: (item) {
                setState(() =>
                  searchTextField.textField.controller.text = item.title
                );

                StoreProvider.of<AppState>(context).dispatch(new UpdateMapFiltersAction(new Map<POIType, bool>()));

                PointOfInterest target = item;
                Navigator.pushNamed(
                  context,
                  mapRoute,
                  arguments: MapPageArguments(target, ""));
              },
              suggestions: pointsOfInterest
          );
          return searchTextField;
        }
    );
  }

  Future<Position> getCurrentPosition() async {
    bool gpsEnabled = await Geolocator().isLocationServiceEnabled();
    if (gpsEnabled)
      return Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
    else
      return await Geolocator().getLastKnownPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
    }
}