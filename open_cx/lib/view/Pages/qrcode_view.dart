import 'dart:convert';
import 'dart:io';

import 'package:communio/model/app_state.dart';
import 'package:communio/view/Pages/general_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:logger/logger.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

class QRCodePage extends StatefulWidget {
  const QRCodePage({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _QRCodePage();
}

class _QRCodePage extends State<QRCodePage>
    with SingleTickerProviderStateMixin {
  final List<Tab> _tabs = <Tab>[Tab(text: "SCAN"), Tab(text: "QRCODE")];
  final AssetImage icon = AssetImage("assets/icon/icon.png");
  final GlobalKey key = GlobalKey();

  bool _enteredInScantab = false;
  final String _scanned = "N/A";
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(vsync: this, length: _tabs.length, initialIndex: 1);
    _tabController.addListener(this._qrgenlistener);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _tabController.addListener(() => {
          setState(() {
            if (this._tabController.index == 0 && !this._enteredInScantab) {
              this._enteredInScantab = true;
              _scanqrcode(context);
            }
          })
        });
    return GeneralPageView(
        child: Container(
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
            child: Column(children: [
              Card(child: _tabbar(context)),
              Expanded(child: _tabviews(context))
            ])));
  }

  _qrgenlistener() {
    setState(() {
      if (this._tabController.index == 1) {
        this._enteredInScantab = false;
      }
    });
  }

  Widget _tabbar(BuildContext context) {
    return TabBar(
      tabs: _tabs,
      controller: _tabController,
      labelColor: Theme.of(context).primaryColor,
      unselectedLabelColor: Theme.of(context).primaryColorLight,
      indicatorColor: Theme.of(context).primaryColor,
    );
  }

  Widget _tabviews(BuildContext context) {
    return TabBarView(
      controller: _tabController,
      children: _tabs.map((Tab tab) {
        final String label = tab.text;
        switch (label) {
          case 'SCAN':
            return _qrscan();
          case 'QRCODE':
            return _qrcodegenerate(context);
          default:
            Navigator.of(context).pop();
            return Container();
        }
      }).toList(),
    );
  }

  Widget _qrscan() {
    return Center(child: Text(_scanned));
  }

  Future<void> _scanqrcode(BuildContext context) async {
    String barcodeScanRes;
    final myUserID =
        StoreProvider.of<AppState>(context).state.content['user_id'];

    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.QR);
    } on PlatformException {
      barcodeScanRes = 'PLATFORM_EXCEPTION_ERROR';
    }

    if (!mounted) return;

    final statuscode = await this.__sendFriendRequest(barcodeScanRes, myUserID);
    setState(() {
      Logger().i("QRCode scanner read: ${barcodeScanRes}");
      Toast.show(this.__responseMessage(statuscode), context,
          duration: Toast.LENGTH_LONG);
      _tabController.index = 1;
    });
  }

  Widget _qrcodegenerate(BuildContext context) {
    final String dataToQR =
        StoreProvider.of<AppState>(context).state.content['user_id'];
    final scalinngFactor = 0.17;
    Logger().i("QR code created with info: ${dataToQR}");
    return Center(
        child: QrImage(
      data: dataToQR,
      errorCorrectionLevel: QrErrorCorrectLevel.H,
      version: QrVersions.auto,
      size: MediaQuery.of(context).size.width * 0.75,
      embeddedImage: icon,
      embeddedImageStyle: QrEmbeddedImageStyle(
          size: Size(MediaQuery.of(context).size.width * scalinngFactor,
              MediaQuery.of(context).size.width * scalinngFactor)),
      foregroundColor: Theme.of(context).colorScheme.primary,
      errorStateBuilder: (cxt, err) {
        Logger().e("Error in QRCode Page: ${err}");
        return Container(
          child: Center(
            child: Text(
              "Uh oh! Something went wrong...",
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    ));
  }

  String __responseMessage(int code) {
    switch (code) {
      case 200:
        return "Friend request sent successfully.";
      case 400:
        return 
        "There seems to be an error with the QR code. Try scanning it again.";
      case 409:
        return "Friend request already sent.";
      case 406:
        return "You are already friends with that user.";
      case 404:
        return "User doesn't exist or you didn't scan a Commun.io qr code.";
      case 500:
        return 
        "Oof! It seems there are problems with the server. Try again later.";
      default:
        return "Unknown error.";
    }
  }

  Future<int> __sendFriendRequest(String otherUserID, String myUserID) async {
    final map = {"id": otherUserID, "user_id": myUserID};
    final response = await http.post(
        '${DotEnv().env['API_URL']}users/matches/request',
        body: json.encode(map),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        });

    return response.statusCode;
  }
}
