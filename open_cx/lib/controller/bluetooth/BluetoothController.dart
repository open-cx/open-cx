import 'dart:async';

import 'package:open_cx/constants/Utility.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'flutter_blue_beacon/beacon.dart';
import 'flutter_blue_beacon/flutter_blue_beacon.dart';


class BluetoothController {
  static BluetoothController _instance;
  Map<int, String> _locationMap = Map(); // maps an int to a string location

  static BluetoothController instance() {
    if (_instance == null) _instance = new BluetoothController();

    return _instance;
  }


  void fillLocationMap(List<String> locations) {
    _locationMap.clear();
    for(int i = 0; i < locations.length; i++) {
      _locationMap.putIfAbsent(i, () => locations.elementAt(i));
    }
  }

  String getLocation(int id){
    return _locationMap[id];
  }


  Future<bool> isBluetoothAvailable() async {
    return await FlutterBlue.instance.isAvailable;
  }

  Future<bool> isBluetoothEnabled() async {
    return await FlutterBlue.instance.isOn;
  }

  Future<Set<int>> searchForBeacons() {
    FlutterBlueBeacon flutterBlueBeacon = FlutterBlueBeacon.instance;

    /// Scanning
    StreamSubscription _scanSubscription;
    Set<int> beacons = Set<int>();


    // Start scanning
    _scanSubscription = flutterBlueBeacon.scan(timeout: const Duration(seconds: scanTimeBLE )).listen((beacon) {

      if (beacon is EddystoneUID) {
        EddystoneUID b = beacon;

        if(int.parse(beacon.namespaceId, radix: 16) == namespaceBLE)
          beacons.add(int.parse(b.beaconId));
      }
    });

     return _scanSubscription.asFuture(beacons);
  }
}
