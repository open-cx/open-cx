import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:open_cx/guideasy_app/constants.dart';
import 'package:open_cx/guideasy_app/model/MapPageArguments.dart';
import 'package:open_cx/guideasy_app/model/PointOfInterest.dart';
import 'package:open_cx/guideasy_app/redux/ActionCreators.dart';
import 'package:open_cx/guideasy_app/view/pages/HomePage.dart';
import 'package:open_cx/guideasy_app/view/pages/MapPage.dart';
import 'package:open_cx/guideasy_app/view/pages/SplashScreen.dart';

import '../../model/AppState.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch(settings.name) {
      case splashRoute:
        return MaterialPageRoute(builder: (_) => new SplashScreen());
      case homeRoute:
        return MaterialPageRoute(builder: (context) {
          StoreProvider.of<AppState>(context).dispatch(getPointsOfInterest());
          return new HomePage();
        });
      case mapRoute:
        final MapPageArguments mapArgs = settings.arguments;
        PointOfInterest initialPOI = mapArgs == null ? null : mapArgs.poi;
        String initialToast = mapArgs == null ? "" : mapArgs.initialToast;

        return MaterialPageRoute(builder: (_) => new MapPage(
            initialTarget: initialPOI,
            initialToast: initialToast
        ));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                  child: Text('No route defined for ${settings.name}')),
            ));
    }
  }
}