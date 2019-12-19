
import 'package:open_cx/Model/bluetooth/Session.dart';
import 'package:open_cx/Components/GenericContainer.dart';
import 'package:open_cx/Components/GenericTitle.dart';
import 'package:open_cx/Components/SessionContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:open_cx/Screens/Search/AboutScreens.dart';
import 'package:open_cx/controller/Controller.dart';
import '../../constants/AppColors.dart' as AppColors;

class BluetoothSearchScreen extends StatefulWidget {
  @override
  BluetoothSearchScreenState createState() => BluetoothSearchScreenState();
}

class BluetoothSearchScreenState extends State<BluetoothSearchScreen> {
  bool _enabledStatus = true;
  bool _scanEnabled = true;
  List<Session> _nearbySessions = List<Session>();


  void _updateEnableStatus(bool status) {
    if(this.mounted) {
      setState(() {
        _enabledStatus = status;
      });
    }
  }

  void _updateNearbySessions(List<Session> sessions) {
    if(this.mounted) {
      setState(() {
        _nearbySessions = sessions;
      });
    }
  }

  Future _refresh() async {
    bool availableStatus = await Controller.instance().isBluetoothAvailable();
    bool enabledStatus = await Controller.instance().isBluetoothEnabled();
    this._updateEnableStatus(availableStatus && enabledStatus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: getBody(),
      floatingActionButton: getScanButton(),
    );
  }

  Widget getAppBar() {
    return AppBar(
      title: Text(
        "Session Search",
        style: TextStyle(color: Colors.white),
        key: Key("Screen title"),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
      backgroundColor: AppColors.mainColor,
      actions: <Widget>[
        getBluetoothStatusIcon(),
        getInfoBarButton(),
      ],
    );
  }

  Widget getInfoBarButton() {
    return IconButton(
        icon: Icon(Icons.info_outline, color: Colors.white),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                        return new SessionScanAboutScreen();
                      }));
        });
  }

  Widget getBody() {
    List<Widget> columnContent = buildSessionContainers();

    List<Widget> listViewWidgets = [this.getIntroductionContainer()];
    if (!_scanEnabled && _enabledStatus) {
      listViewWidgets.add(Padding(
        padding: const EdgeInsets.only(top: 125.0),
        child: Image(image: AssetImage("assets/images/AMA.gif")),
        )
      );
    }
    else {
      listViewWidgets.add(getScanMessage(columnContent.isEmpty));
      columnContent.forEach((elem) => listViewWidgets.add(elem));
    }

    return Container(
      color: AppColors.backgroundColor,
      child: ListView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(10.0),
        children: listViewWidgets,
      ),
    );
  }



  Widget getIntroductionContainer() {
    String introText;

    if (!_enabledStatus)
      introText = "But you'll need to enable bluetooth first...";
    else
      introText = "Tap the 'scan' button whenever you're ready to explore.";

    return GenericContainer(title: "Know what's around ", text: introText);
  }

  //
  // Bluetooth status
  //

  Widget getBluetoothStatusIcon() {
    return FutureBuilder(
        future: _refresh(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return (_enabledStatus
              ? Icon(Icons.bluetooth, color: Colors.white)
              : Icon(Icons.bluetooth_disabled, color: Colors.white));
        });
  }

  //
  // Bluetooth scanning (nearby session)
  //


  Widget getScanMessage(bool empty) {
    if(empty) {
      return Padding(
        padding: const EdgeInsets.only(top: 170.0),
        child: Text(
          "Looks like there are no sessions nearby :(",
          style: TextStyle(fontSize: 20, color: Colors.black87),
          textAlign: TextAlign.center,
        ),
      );
    }
    else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GenericTitle(
              title: "Sessions near you:",
              padding: EdgeInsets.all(6.0),
              margin: EdgeInsets.all(10.0),
              style: TextStyle(
                  color: AppColors.mainColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 20),
          ),
        ],
      );
    }
  }


  List<Widget> buildSessionContainers() {
    List<Widget> result = List<Widget>();

    for (int i = 0; i < _nearbySessions.length; i++) {
      result.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: SessionContainer(activity: _nearbySessions[i]),
      ));
    }

    return result;
  }

  Future getNearbySessions() async {
    _scanEnabled = false;

    Set<int> beaconLocationIDs = await Controller.instance().searchForBeaconLocations();
    List<Session> nbSessions = await Controller.instance()
        .getSessionsNearby(beaconLocationIDs);

    this._updateNearbySessions(nbSessions);

    _scanEnabled = true;
  }

  //
  // Scan button
  //

  Widget getScanButton() {
    return FutureBuilder<bool>(
      future: Controller.instance().isBluetoothOK(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return this.getFloatingButton(snapshot.data);
      },
    );
  }

  Widget getFloatingButton(bool visibility) {
    if (visibility == null) visibility = false;

    return Visibility(
      visible: visibility,
      child: FloatingActionButton(
        onPressed: () {
          if (_scanEnabled) getNearbySessions();
        },
        tooltip: 'Scan',
        backgroundColor:
            _scanEnabled ? AppColors.mainColor : Colors.black38,
        child: _scanEnabled
            ? Icon(Icons.search)
            : Icon(Icons.not_interested),
      ),
    );
  }
}
