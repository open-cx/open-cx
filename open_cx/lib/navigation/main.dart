import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:open_cx/navigation/constants.dart';
import 'package:open_cx/navigation/model/AppState.dart';
import 'package:open_cx/navigation/redux/Reducers.dart';
import 'package:redux/redux.dart';

import '../navigation/Theme.dart';
import '../navigation/controller/Middleware.dart';
import '../navigation/controller/routes/Router.dart';

final Store<AppState> state = Store<AppState>(
    appReducers, /* Function defined in the reducers file */
    initialState: new AppState(null),
    middleware: [generalMiddleware]
);

void main() => runApp(new GuideasyApp());

class GuideasyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: state,
      child: MaterialApp(
        title: 'Guideasy App',
        theme: applicationTheme,
        initialRoute: homeRoute,
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}

