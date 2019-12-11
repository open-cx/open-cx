import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:open_cx/guideasy_app/controller/local_storage/POIDatabase.dart';
import 'package:open_cx/guideasy_app/model/AppState.dart';
import 'package:open_cx/guideasy_app/model/PointOfInterest.dart';
import 'package:open_cx/guideasy_app/redux/Actions.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';

ThunkAction<AppState> getPointsOfInterest() {
  return (Store<AppState> store) async {
    store.dispatch(updateStateBasedOnLocalPOIs());
    store.dispatch(getRemotePointsOfInterest());
  };
}

ThunkAction<AppState> getRemotePointsOfInterest() {
  return (Store<AppState> store) async {
    try {
      store.dispatch(new SavePOIsStatusAction(RequestStatus.BUSY));
      
      // retrieve points of interest
      List<PointOfInterest> pointsOfInterest = new List<PointOfInterest>();
      String jsonString = await rootBundle.loadString('assets/guideasy_app/locations_db/locations.json');
      Map parsedJson = json.decode(jsonString);
      
      var categoryJson = parsedJson['locations'] as List;
      for(int i = 0; i < categoryJson.length; i++) {
        pointsOfInterest.add(new PointOfInterest.fromJson(i+1, categoryJson[i]));
      }

      // save points of interest in the database
      POIDatabase pointsOfInterestDB = POIDatabase();
      await pointsOfInterestDB.saveNewPOIs(pointsOfInterest);

      // store points of interest in store
      store.dispatch(new SavePOIsAction(pointsOfInterest));
      store.dispatch(new SavePOIsStatusAction(RequestStatus.SUCCESSFUL));
    } catch (e) {
      print("Failed to get POIs info");
      print(e.toString());
      store.dispatch(new SavePOIsStatusAction(RequestStatus.FAILED));
    }
  };
}

ThunkAction<AppState> updateStateBasedOnLocalPOIs() {
  return (Store<AppState> store) async {
    // read pois from database
    POIDatabase pointsOfInterestDB = POIDatabase();
    List<PointOfInterest> pointsOfInterest = await pointsOfInterestDB.getPOIs();

    if(pointsOfInterest.length > 0)
      // store points of interest in store
      store.dispatch(new SavePOIsAction(pointsOfInterest));
    else
      print("No POI info stored locally");
  };
}