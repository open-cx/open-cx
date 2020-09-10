import 'package:communio/model/app_state.dart';
import 'package:communio/model/person_found.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:communio/main.dart' as app;
import 'package:redux/redux.dart';
import 'package:communio/controller/middleware.dart';
import 'package:communio/redux/reducers.dart';


void main() {

  final Store<AppState> state = Store<AppState>(appReducers,
    /* Function defined in the reducers file */
    initialState: new AppState(null),
    middleware: [generalMiddleware]);
  final person1 = PersonFound(
      name: "John Doe",
      photo: "https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=80",
      location: "Portugal",
      interests: ["Big Data", "AI"]);
  final person2 = PersonFound(
      name: "John Doe",
      photo: "https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=80",
      location: "Portugal",
      interests: ["Big Data"]);
  
  final  people = Map.fromIterables(
      ["key1", "key2"], [person1, person2]);

  state.state.content['bluetooth_devices'] = people;
  state.state.content['scanning_on'] = true;
  state.state.content['profile'] = 'http://www.mocky.io/v2/5dfa00e7360000d189bd691b';
  state.state.content['connected'] = 'http://www.mocky.io/v2/5dfa0a943600007100bd698f';
  state.state.content['friend_request'] = 'http://www.mocky.io/v2/5dfaa5342f00005700ff9aa7';
  state.state.content['user_id'] = '';
  enableFlutterDriverExtension();
  app.enableApp(state);
}

