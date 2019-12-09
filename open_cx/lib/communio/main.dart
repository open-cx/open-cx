import 'package:open_cx/communio/model/app_state.dart';
import 'package:open_cx/communio/redux/reducers.dart';
import 'package:open_cx/communio/view/Pages/bluetooth_beacon_selection.dart';
import 'package:open_cx/communio/view/Pages/connected_listing_page.dart';
import 'package:open_cx/communio/view/Pages/create_profile_page.dart';
import 'package:open_cx/communio/view/Pages/people_searching_page.dart';
import 'package:open_cx/communio/view/Pages/qrcode_view.dart';
import 'package:open_cx/communio/view/Pages/profile_page.dart';
import 'package:open_cx/communio/view/Pages/set_beacon_page.dart';
import 'package:open_cx/communio/view/Pages/settings_page_view.dart';
import 'package:open_cx/communio/view/navigation_service.dart';
import 'package:open_cx/communio/view/Pages/homepage_view.dart';
import 'package:open_cx/communio/controller/middleware.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'view/theme.dart';
import 'model/app_state.dart';
import 'package:redux/redux.dart';
import 'redux/reducers.dart';

final Store<AppState> state = Store<AppState>(appReducers,
    /* Function defined in the reducers file */
    initialState: new AppState(null),
    middleware: [generalMiddleware]);

void main() {
  DotEnv().load('.env');
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  WidgetsBindingObserver lifeCycleEventHandler;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return StoreProvider(
      store: state,
      child: MaterialApp(
          title: 'Communio',
          theme: applicationTheme,
          home: HomePageView(),
          navigatorKey: NavigationService.navigatorKey,
          // ignore: missing_return
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
              case '/Homepage':
                return MaterialPageRoute(
                    builder: (context) => HomePageView(), settings: settings);
              case '/PeopleSearch':
                return MaterialPageRoute(
                    builder: (context) => PeopleSearchingPage(),
                    settings: settings);
              case '/QRCode':
                return MaterialPageRoute(
                    builder: (context) => QRCodePage(), settings: settings);
              case '/ListConnected':
                return MaterialPageRoute(
                    builder: (context) => ConnectedListingPage(),
                    settings: settings);
              case '/Settings':
                return MaterialPageRoute(
                    builder: (context) => SettingsPageView(),
                    settings: settings);
              case '/SetBeacon':
                return MaterialPageRoute(
                    builder: (context) => SetBeaconPage(),
                    settings: settings);
              case '/BluetoothBeaconSelection':
                return MaterialPageRoute(
                    builder: (context) => BluetoothBeaconSelection(),
                    settings: settings);
              case '/Profile':
                final String profile = state.state.content['user_id'];
                return MaterialPageRoute(
                    builder: (context) => ProfilePage(
                          profileId: profile,
                          edit: true,
                        ),
                    settings: settings,
                    maintainState: false);
              case '/CreateProfile':
                return MaterialPageRoute(
                  builder: (context) => CreateProfilePage(),
                  settings: settings);
            }
          }),
    );
  }
}
