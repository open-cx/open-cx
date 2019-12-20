import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'Connection.dart';

/// A [PointOfInterest] is a marker on our map in which the
/// user might find something useful
class PointOfInterest {
  /// Unique identification number
  final int _id;
  /// GPS Coordinates
  final LatLng _location;
  /// Floor number
  final int _floor;
  /// Other POIs accessible through this POI
  List<Connection> _connections;

  /// Constructor
  PointOfInterest(this._id, this._location, this._floor) { //this._rooms
    this._connections = new List<Connection>();
  }

  /// Getter member function for [_id]
  /// returns an [int] indicating [PointOfInterest]'s ID
  int get id => _id;

  /// Getter member function for [_location]
  /// returns a [LatLng] Object GPS coordinates
  LatLng get location => _location;

  /// Getter member function for [_floor]
  /// returns an [int] indicating POI floor number
  int get floor => _floor;

  /// Getter member function for [_connections]
  /// returns a [List] containing all connections for this POI
  List<Connection> get connections => _connections;

  /// Getter member function for [_rooms]
  /// returns a [List] containing all rooms accessible through for this POI
  // List<String> get rooms => _rooms;

  /// Adds a new [Connection] to the [_connections] list
  /// creating a new instance of [Connection] given its ID
  /// and destination POI ID
  void addConnection(int connectionId, int destPointId) {
    this._connections.add(new Connection(connectionId, destPointId));
  }

  /// Factory constructor
  /// Given a a JSON Map ([json]) a new instance of [PointOfInterest]
  /// is created and returned
  factory PointOfInterest.fromJson(Map<String, dynamic> json) {
    // get latitude and longitude
    LatLng location = new LatLng(json['latitude'] as double, json['longitude'] as double);

    return PointOfInterest (
        json['poiId'] as int,
        location,
        json['floor'] as int
    );
  }
}
