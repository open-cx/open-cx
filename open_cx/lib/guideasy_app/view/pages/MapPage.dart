import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:open_cx/guideasy_app/model/AppState.dart';
import 'package:open_cx/guideasy_app/model/PointOfInterest.dart';
import 'package:open_cx/guideasy_app/view/widgets/FilterBox.dart';

class MapPage extends StatefulWidget {
  final PointOfInterest initialTarget;
  final String initialToast;

  @override
  _ConferenceMap createState() => _ConferenceMap();

  MapPage({Key key, @required this.initialTarget, @required this.initialToast}) : super(key: key);
}

class _ConferenceMap extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  bool firstToast = true;

  static final CameraPosition _eventLocation = CameraPosition(
    bearing: 0,
    target: LatLng(41.17785, -8.596625),
    tilt: 0,
    zoom: 18
  );

  StreamSubscription _netSubscription;

  void initState() {
    _netSubscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if(widget.initialToast != "" && firstToast) {
        setState(() {
          firstToast = false;
        });
        return;
      }

      if (result == ConnectivityResult.none)
        showMapToast("No Internet connection.");
    });

    if (widget.initialToast != "")
      showMapToast(widget.initialToast);

    super.initState();
  }

  void dispose() {
    super.dispose();
    _netSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
        key: const Key("Map page"),
        resizeToAvoidBottomPadding: false,
        backgroundColor: Color(0xffff9900),
        appBar: AppBar(
          title: Center(
            child: Text(
              'Guideasy',
              style: theme.textTheme.headline,
            )
          ),
          backgroundColor: Color(0xffff9900),
        ),
        body: GoogleMap(
          mapType: MapType.terrain,
          onMapCreated: (GoogleMapController controller)  {
            _controller.complete(controller);

            setState(() {
              markers.clear();
            });

            if(widget.initialTarget != null) {
              addMarkerFromPOI(widget.initialTarget);
              _animateToTargetPOI(widget.initialTarget, 600);
            }
            else
              updateMarkers(context);
          },
          initialCameraPosition: _eventLocation,
          markers: Set<Marker>.of(markers.values),
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          indoorViewEnabled: true
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: _recenterMap,
            label: Text('Recenter Map'),
            icon: Icon(Icons.gps_fixed),
            backgroundColor: Theme.of(context).backgroundColor
        ),
        endDrawer: Tooltip(
          message: "Map filters",
          child: new FilterBox(
            //key: const Key("map filters button"),
              onChangeFilter: () {
                updateMarkers(context);
              })
        )
    );
  }

  void _animateToTargetPOI(PointOfInterest target, int initialDelay) {
    Future.delayed(Duration(milliseconds: initialDelay), () {
      _animateTo(LatLng(target.latitude, target.longitude), 22);
    });

    Future.delayed(const Duration(seconds: 3), () async{
      Position position;
      bool gpsEnabled = await Geolocator().isLocationServiceEnabled();
      if (gpsEnabled) {
        position = await Geolocator().getCurrentPosition(
            desiredAccuracy: LocationAccuracy.bestForNavigation
        );
      } else {
        position = await Geolocator().getLastKnownPosition(
            desiredAccuracy: LocationAccuracy.bestForNavigation
        );
      }

      if (position != null) {
        _animateTo(LatLng(position.latitude, position.longitude), 18);
      }
      else {
        showMapToast("Could not find current location.");
        _recenterMap();
      }

    });
  }

  Future<void> _recenterMap() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_eventLocation));
  }

  void _animateTo(LatLng pos, double zoom) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(pos, zoom));
  }

  void updateMarkers(BuildContext context) {
    final Map content = StoreProvider.of<AppState>(context).state.content;
    List<PointOfInterest> pointsOfInterest = content['pointsOfInterest'];

    setState(() {
      markers.clear();
    });
    pointsOfInterest.forEach((PointOfInterest poi) {
      if (content['mapFilters'][poi.type] != true) return;
      addMarkerFromPOI(poi);
    });
  }

  void addMarkerFromPOI(PointOfInterest poi) {
    String floorText = poi.floors.contains(',') ? ", Floors " : ", Floor ";
    MarkerId markerId = MarkerId(poi.id.toString());
    Marker newMarker = Marker(
        markerId: markerId,
        position: LatLng(poi.latitude, poi.longitude),
        infoWindow: InfoWindow(
            title: poi.title + floorText + poi.floors,
            snippet: poi.description,
            onTap: () {
              _animateToTargetPOI(poi, 100);
            }
        )
    );

    setState(() {
      markers[markerId] = newMarker;
    });
  }
}

void showMapToast(String content) {
  Fluttertoast.showToast(
    msg: content,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIos: 1,
    backgroundColor: Colors.orangeAccent,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}