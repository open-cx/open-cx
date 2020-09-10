import 'package:communio/controller/friend_notifications.dart';
import 'package:communio/model/app_state.dart';
import 'package:communio/redux/reducers.dart';
import 'package:communio/view/Pages/bluetooth_beacon_selection.dart';
import 'package:communio/view/Pages/connected_listing_page.dart';
import 'package:communio/view/Pages/create_profile_page.dart';
import 'package:communio/view/Pages/friend_requests_page.dart';
import 'package:communio/view/Pages/people_searching_page.dart';
import 'package:communio/view/Pages/qrcode_view.dart';
import 'package:communio/view/Pages/profile_page.dart';
import 'package:communio/view/Pages/set_beacon_page.dart';
import 'package:communio/view/Pages/settings_page_view.dart';
import 'package:communio/view/navigation_service.dart';
import 'package:communio/view/Pages/homepage_view.dart';
import 'package:communio/controller/middleware.dart';
import 'package:flutter/material.dart';
import 'package:open_cx/networking/main.dart';
import 'package:open_cx/program/AgendApp.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'view/theme.dart';
import 'model/app_state.dart';
import 'package:redux/redux.dart';
import 'redux/reducers.dart';


initialLoad() async {
  await DotEnv().load('.env');
  final Store<AppState> state = Store<AppState>(appReducers,
    /* Function defined in the reducers file */
    initialState: new AppState(null),
    middleware: [generalMiddleware]);
  setupNotifications(state.state.content['user_id']);
  enableApp(state);
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ESOF Demo',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(3, 44, 115, 1),
      ),
      initialRoute: '/',
      routes: {
        "/": (context) => HomePage(),
        "/yourPage": (context) => YourProject(),
        "/agendAppMain": (context) => AgendAppMain(),
        "/communio": (context) => Communio()
      },
    );
  }
}

enableApp(Store<AppState> state){
  runApp(new MyApp(state: state,));
}

void main() {
  initialLoad();
}

class MyApp extends StatefulWidget {
  final Store<AppState> state;

  MyApp({@required this.state});
  
  @override
  State<StatefulWidget> createState() {
    return MyAppState(state);
  }
}

class MyAppState extends State<MyApp> {
  WidgetsBindingObserver lifeCycleEventHandler;
  final Store<AppState> state;

  MyAppState(this.state);

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
              case '/Friend-Requests':
                return MaterialPageRoute(
                    builder: (context) => FriendRequestsPage(),
                    settings: settings);
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
