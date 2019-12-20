import 'dart:collection';
import 'dart:math';

import 'Connection.dart';
import 'PointOfInterest.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// [PointOfInterest] Graph implementation using a [HashMap] as a Node container
class Graph {
  /// POIs and their connections that make up a Graph
  HashMap<int, PointOfInterest> _pointsOfInterest;

  /// Constructor
  Graph() {
    this._pointsOfInterest = new HashMap<int, PointOfInterest>();
  }

  /// Getter member function for [_pointsOfInterest]
  /// returns a [HashMap] containing [PointOfInterest] Objects
  HashMap<int, PointOfInterest> get pointsOfInterest => _pointsOfInterest;


  /// Adds a new [PointOfInterest] to the [_pointsOfInterest] list
  /// given its ID as key
  void addPointOfInterest(PointOfInterest poi) {
    _pointsOfInterest[poi.id] = poi;
  }

  /// Returns a specific [PointOfInterest] given its ID [pointId],
  /// in case [pointId] does not exist in [_pointsOfInterest] returns null
  PointOfInterest getPointOfInterest(int pointId) {
    return _pointsOfInterest[pointId];
  }

  /// Returns connection list from a specific [PointOfInterest] given
  /// its ID [pointID]
  List<Connection> getConnections(int pointId) {
    return _pointsOfInterest[pointId].connections;
  }

  /// Returns closest [PointOfInterest] closest to given [LatLng]
  PointOfInterest getClosestPointOfInterest(LatLng coordinates) {
    // get first poi
    PointOfInterest returnPOI;
    // closest distance
    double distance = double.maxFinite;
    // loop through all POIs
    this._pointsOfInterest.forEach(
            (key, poi) {
          double nextDistance = this.getDistance(coordinates, poi.location);
          if (nextDistance < distance) {
            returnPOI = poi;
            distance = nextDistance;
          }
        }
    );
    return returnPOI;
  }

  /// Returns the distance between two GPS Coordinates
  double getDistance(LatLng pointA, LatLng pointB) {
    return sqrt(pow(pointA.latitude.abs() - pointB.latitude.abs(), 2) + pow(pointA.longitude.abs() - pointB.longitude.abs(), 2));
  }

}