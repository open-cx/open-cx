import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:open_cx/location/components/CustomRaisedButton.dart';
import 'package:open_cx/location/components/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:open_cx/location/users.dart';


class Map2 extends StatelessWidget {
  final double lat;
  final double long;
  final String name;

  Map2({Key key, @required this.lat, @required this.long, @required this.name}) : super(key: key);
  @override


  Completer<GoogleMapController> _controller = Completer();


  Set<Marker> markers = Set();

@override
  Widget build(BuildContext context) {
  CameraPosition user = CameraPosition(target: LatLng(getLat(), getLong()), zoom: 17);
  markers.add(Marker(
      markerId: MarkerId(name),
      infoWindow: InfoWindow(
          title: name),
      //position: LatLng(lat, long)
      position: LatLng(lat,long)
  ));
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
                              markers: markers,

                              onMapCreated: (GoogleMapController controller){
                                print("map ready");
                                // ADD TARGETS

                                _controller.complete(controller);



                              },
                            )
                        )
                        // add new Widgets here.
                      ]))]))
    ) ;
  }

  void afterFirstLayout(BuildContext context) {
    // Calling the same function "after layout" to resolve the issue.
    //TODO
   ;
  }


  double getLat(){
    return this.lat;
  }


  double getLong(){
    return this.long;
  }
}


Position getposition(){
  Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high) as Position;
}

 //URRENT BUGS -> speakersList is updated as user writes / deletes letters. But the Widget doesn't update its information.