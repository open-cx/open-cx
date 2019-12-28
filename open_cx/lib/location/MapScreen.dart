import 'dart:async';

import 'package:flutter/material.dart';
import 'package:open_cx/location/components/CustomRaisedButton.dart';
import 'package:open_cx/location/components/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:open_cx/location//users.dart';


class MapScreen extends StatefulWidget {

  MapScreen({Key key, position}) : super(key: key);
  @override
  _MapScreen createState() => new _MapScreen();

}



class _MapScreen extends State<MapScreen> {

  static var geolocator = Geolocator();
  static var locationOptions = LocationOptions(accuracy: LocationAccuracy.best, distanceFilter: 1);


  StreamSubscription<Position> positionStream = geolocator.getPositionStream(
      locationOptions).listen( (Position position) => print(
          position == null ? 'Unknown' : position.latitude.toString() + ', ' +
              position.longitude.toString()));
  static Future<Position> position = geolocator.getCurrentPosition();
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition user = CameraPosition(target: LatLng(feup_loc.elementAt(0), feup_loc.elementAt(1)), zoom: 17);
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: colorPallete[900],
        body: SingleChildScrollView(
        child: Stack(
        children: <Widget>[
        new SafeArea(child:
        new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[

              new SpearchLogo(),

              new Container(
                  height:MediaQuery.of(context).size.height*0.70,
                  child:
                  GoogleMap(
                    mapType: MapType.hybrid,
                    initialCameraPosition: user,
                    onMapCreated: (GoogleMapController controller){
                      _controller.complete(controller);
                    },
                  )
              )
              // add new Widgets here.
            ]))]))
    ) ;

  }
}


Position getposition(){
  Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high) as Position;
}

