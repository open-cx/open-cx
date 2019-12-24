import 'package:open_cx/networking/controller/friend_notifications.dart';
import 'package:open_cx/networking/model/app_state.dart';
import 'package:open_cx/networking/redux/reducers.dart';
import 'package:open_cx/networking/view/Pages/bluetooth_beacon_selection.dart';
import 'package:open_cx/networking/view/Pages/connect_page.dart';
import 'package:open_cx/networking/view/Pages/connected_listing_page.dart';
import 'package:open_cx/networking/view/Pages/create_profile_page.dart';
import 'package:open_cx/networking/view/Pages/friend_requests_page.dart';
import 'package:open_cx/networking/view/Pages/people_searching_page.dart';
import 'package:open_cx/networking/view/Pages/qrcode_view.dart';
import 'package:open_cx/networking/view/Pages/profile_page.dart';
import 'package:open_cx/networking/view/Pages/set_beacon_page.dart';
import 'package:open_cx/networking/view/Pages/settings_page_view.dart';
import 'package:open_cx/networking/view/navigation_service.dart';
import 'package:open_cx/networking/view/Pages/homepage_view.dart';
import 'package:open_cx/networking/controller/middleware.dart';
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

initialLoad() async {
  await DotEnv().load('.env');
  setupNotifications(state.state.content['user_id']);
}

void main() {
  runApp(new Communio());
}

class Communio extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    initialLoad();
    return CommunioAppState();
  }
}

class CommunioAppState extends State<Communio> {
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
          home: PeopleSearchingPage(),
          navigatorKey: NavigationService.navigatorKey,
          // ignore: missing_return
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
              case '/PeopleSearch':
                return MaterialPageRoute(
                    builder: (context) => PeopleSearchingPage(),
                    settings: settings);
              case '/QRCode':
                return MaterialPageRoute(
                    builder: (context) => QRCodePage(), settings: settings);
              case '/Friend Requests':
                return MaterialPageRoute(
                    builder: (context) => FriendRequestsPage(),
                    settings: settings);
              case '/ListConnected':
                return MaterialPageRoute(
                    builder: (context) => ConnectedListingPage(),
                    settings: settings);
              case '/Connect by micro:bit':
                return MaterialPageRoute(
                    builder: (context) => ConnectionsPage(),
                    settings: settings);
              case '/Settings':
                return MaterialPageRoute(
                    builder: (context) => SettingsPageView(),
                    settings: settings);
              case '/SetBeacon':
                return MaterialPageRoute(
                    builder: (context) => SetBeaconPage(), settings: settings);
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
