import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:open_cx/Navigation/BFS.dart';
import 'package:open_cx/Navigation/Graph.dart';
import 'package:open_cx/Navigation/Place.dart';
import 'package:open_cx/Navigation/PointOfInterest.dart';
import 'package:http/http.dart' as http;


/// Data Server simulation
class DataServer {
  /// [String] with server host
  String _host;
  /// [Map] containing all POIs
  Map<int, PointOfInterest> _pointsOfInterest;
  /// [Graph] representing FEUP's building
  Graph _poiGraph;
  /// [BFS] to perform searches
  BFS _bfs;
  /// [DataServer] singleton instance
  static final DataServer _dataServerInstance = DataServer._constructor();

  /// Private Constructor
  DataServer._constructor() {
    // host
    this._host = "http://open-cx.herokuapp.com";
    // Graph and POI
    this._pointsOfInterest = new Map<int, PointOfInterest>();
    this._poiGraph = new Graph();
    this._bfs = new BFS(this._poiGraph);
  }

  /// Factory Constructor for singleton instance
  factory DataServer() {
    return _dataServerInstance;
  }

  /// Getter member function for [_pointsOfInterest]
  /// returns a [Map] of [PointOfInterest] Objects
  Map<int, PointOfInterest> get pointsOfInterest => _pointsOfInterest;

  /// Getter member function for [_bfs]
  /// returns a [BFS] Object
  BFS get bfs => _bfs;

  /// return path from event given
  List<LatLng> getPathToPOI(LatLng userPosition, int destinationPoint) {
    List<LatLng> coordsPath = new List<LatLng>();
    // user position is the first element to be displayed on list
    coordsPath.add(userPosition);
    // get closest POI from userPosition and find path from closest POI to destination POI
    PointOfInterest closestPOI = this._poiGraph.getClosestPointOfInterest(userPosition);
    if (!this._bfs.execute(closestPOI.id, destinationPoint)) {
      // search failed, return list with user position and destination point
      coordsPath.add(this._pointsOfInterest[destinationPoint].location);
      return coordsPath;
    }
    // get POI path
    List<int> path = this._bfs.path.reversed.toList();
    // build LatLng path from POI's id
    path.forEach(
            (pointId) {
          coordsPath.add(this._pointsOfInterest[pointId].location);
        }
    );
    return coordsPath;
  }

  /// Loads entire data from server and build graph
  Future<void> loadGraphData() async {
    // load POI data (Nodes and Edges)
    await this._loadPOIData();
    await this._loadConnectionData();
    // build graph
    this._buildGraph();
  }

  /// After parsing all the data it is necessary to build [Graph]
  /// for path-finding
  void _buildGraph() {
    _pointsOfInterest.forEach(
            (key, poi) {
          _poiGraph.addPointOfInterest(poi);
        }
    );
  }

  /// Return [Place] object containing coffee lounge information gotten from server
  Future<Place> getCoffeeLounge() async {
    final response = await http.get('${this._host}/places/');
    // check if call was successful
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      List placesList = json.decode(response.body);
      // Search for Vending Machines
      for (var place in placesList) {
        if(place["placeName"] == "Coffee Lounge")
          return Place.fromJson(place);
        else
          throw Exception('Coffee Lounge not found');
      }
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load Coffee Lounge');
    }
  }

  /// Return [Place] object containing check in information gotten from server
  Future<Place> getCheckIn() async {
    final response = await http.get('${this._host}/places/');
    // check if call was successful
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      List placesList = json.decode(response.body);
      // Search for Vending Machines
      for (var place in placesList) {
        if(place["placeName"] == "Check In")
          return Place.fromJson(place);
        else
          throw Exception('Check In not found');
      }
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load Check In');
    }
  }

  /// Return [List] of [Place] object containing Vending machines information gotten from server
  Future<List<Place>> getVendingMachines() async {
    final response = await http.get('${this._host}/places');
    // check if call was successful
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      List placesList = json.decode(response.body);
      // Search for Vending Machines
      List<Place> vendingMachines = new List<Place>();
      for (var place in placesList) {
        if(place["placeName"] == "Vending Machine")
          vendingMachines.add(Place.fromJson(place));
      }
      return vendingMachines;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load Vending Machines');
    }
  }

  /// Return [List] of [Place] object containing Exits information gotten from server
  Future<List<Place>> getExits() async {
    final response = await http.get('${this._host}/places');
    // check if call was successful
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      List placesList = json.decode(response.body);
      // Search for Vending Machines
      List<Place> exits = new List<Place>();
      for (var place in placesList) {
        if(place["placeName"].endsWith('Exit'))
          exits.add(Place.fromJson(place));
      }
      return exits;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load Exits');
    }
  }

  /// Return [List] of [Place] object containing Male Bathroom information gotten from server
  Future<List<Place>> getMaleBathrooms() async {
    final response = await http.get('${this._host}/places');
    // check if call was successful
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      List placesList = json.decode(response.body);
      // Search for Vending Machines
      List<Place> bathrooms = new List<Place>();
      for (var place in placesList) {
        if(place["placeName"] == "Male WC")
          bathrooms.add(Place.fromJson(place));
      }
      return bathrooms;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load Exits');
    }
  }

  /// Return [List] of [Place] object containing Male Bathroom information gotten from server
  Future<List<Place>> getFemaleBathrooms() async {
    final response = await http.get('${this._host}/places');
    // check if call was successful
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      List placesList = json.decode(response.body);
      // Search for Vending Machines
      List<Place> bathrooms = new List<Place>();
      for (var place in placesList) {
        if(place["placeName"] == "Female WC")
          bathrooms.add(Place.fromJson(place));
      }
      return bathrooms;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load Exits');
    }
  }

  /// Loads json file related to POIs and returns json string
  Future<List> _loadPOIDataAsset() async {
    var response = await http.get('${this._host}/pois');
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      return json.decode(response.body);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load Points of Interest');
    }
  }

  /// Creates [PointOfInterest] objects from json file and stores them
  /// in [_pointsOfInterest] Map
  Future<void> _loadPOIData() async {
    List jsonPOIs = await this._loadPOIDataAsset();

    jsonPOIs.forEach(
            (v) {
          int actualKey = v['poiId'];
          this._pointsOfInterest[actualKey] = PointOfInterest.fromJson(v);
        }
    );
  }

  /// Loads json file related to POI connections and returns json string
  Future<List> _loadConnectionDataAsset() async {
    var response = await http.get('${this._host}/connections');
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      return json.decode(response.body);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load Connections');
    }
  }

  /// Creates [Connection] objects from json file and adds them to
  /// respective [PointOfInterest] stored in [_pointsOfInterest] Map
  Future<void> _loadConnectionData() async {
    List jsonConnections = await this._loadConnectionDataAsset();

    int connectionId = 1;
    jsonConnections.forEach(
            (v) {
          int sourcePointId = v['connectionId'];
          v['connections'].forEach(
                  (destPointId) {
                this._pointsOfInterest[sourcePointId].addConnection(connectionId++, destPointId as int);
              }
          );
        }
    );
  }
}