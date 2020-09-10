import 'package:communio/model/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

makeReduxTestableWidget(Widget child, Store<AppState> state) => StoreProvider(
  store: state,
  child: MaterialApp(
    home: child
  ),
);