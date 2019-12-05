

import 'package:flutter/cupertino.dart';
import 'package:open_cx/guideasy_app/controller/map_navigation/MapPosition.dart';
import 'package:open_cx/guideasy_app/model/POIType.dart';
import 'package:open_cx/guideasy_app/model/PointOfInterest.dart';

PointOfInterest nearestPOIOfType(MapPosition position, POIType type, List<PointOfInterest> pointsOfInterest) {
  PointOfInterest nearest;
  double nearestDist = 999999999;

  pointsOfInterest.forEach((PointOfInterest poi) {
      if(poi.type != type) return;

      MapPosition currpos = MapPosition(poi.latitude, poi.longitude);
      double currentDist = position.distanceTo(currpos);
      if (nearest == null || currentDist < nearestDist) {
       nearest = poi;
       nearestDist = currentDist;
      }
    }
  );

  return nearest;
}

void resetMapFilters(BuildContext context) {

}