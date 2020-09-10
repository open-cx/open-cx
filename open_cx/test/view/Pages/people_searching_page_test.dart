import 'package:communio/controller/middleware.dart';
import 'package:communio/model/app_state.dart';
import 'package:communio/model/person_found.dart';
import 'package:communio/redux/reducers.dart';
import 'package:communio/view/Pages/people_searching_page.dart';
import 'package:communio/view/Widgets/photo_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/gen/flutterblue.pbserver.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_test_utils/image_test_utils.dart';
import 'package:mockito/mockito.dart';
import 'package:redux/redux.dart';

import '../../../test_driver/make_redux_testable_widget.dart';

class MockBluetoothDevice extends Mock implements BluetoothDevice {}

void main() {
  group('People Searching Page tests', () {
    final name1 = "John Doe";
    final photo1 =
        "https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=80";
    final location1 = "Portugal";
    final interest1 = "Big Data";
    final interest2 = "AI";
    final person1 = PersonFound(
        name: name1,
        photo: photo1,
        location: location1,
        interests: [interest1, interest2]);

    final person2 = PersonFound(
        name: name1,
        photo: photo1,
        location: location1,
        interests: [interest1]);

    testWidgets('Page with no filters', (WidgetTester tester) async {
      provideMockedNetworkImages(() async {
        final  people = Map.fromIterables(
            ["key1", "key2"], [person1, person2]);

        final store = Store<AppState>(appReducers,
            initialState: new AppState({
              "bluetooth_devices": Map.from(people),
              "current_filters": Set<String>(),
              "scanning_on": true
            }),
            middleware: [generalMiddleware]);
        final Widget testableWidget =
            makeReduxTestableWidget(PeopleSearchingPage(), store);

        await tester.pumpWidget(testableWidget);
        
        expect(
            find.descendant(
                of: find.byKey(Key('people-searching-page')),
                matching: find.byType(PhotoAvatar)),
            findsNWidgets(2));
      });
    });
    testWidgets('Page with a single filter', (WidgetTester tester) async {
      provideMockedNetworkImages(() async {
        final  people = Map.fromIterables(
            ["key1", "key2"], [person1, person2]);

        final Set<String>  filters= Set();
        filters.add(interest2);

        final store = Store<AppState>(appReducers,
            initialState: new AppState({
              "bluetooth_devices": Map.from(people),
              "current_filters": filters,
              "scanning_on": true
            }),
            middleware: [generalMiddleware]);
        final Widget testableWidget =
            makeReduxTestableWidget(PeopleSearchingPage(), store);

        await tester.pumpWidget(testableWidget);

        expect(
            find.descendant(
                of: find.byKey(Key('people-searching-page')),
                matching: find.byType(PhotoAvatar)),
            findsOneWidget);
      });
    });
  });
}
