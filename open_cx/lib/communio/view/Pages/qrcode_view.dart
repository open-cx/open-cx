import 'package:open_cx/communio/view/Pages/general_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:logger/logger.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:toast/toast.dart';

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
  final dataToQR = "PLACE_HOLDER_FOR_1_ON_1_CONNECTION";

  bool _enteredInScantab = false;
  String _scanned = "N/A";
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

    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.QR);
    } on PlatformException {
      barcodeScanRes = 'PLATFORM_EXCEPTION_ERROR';
    }

    if (!mounted) return;

    setState(() {
      _scanned = (barcodeScanRes == "-1") ? _scanned : barcodeScanRes;
      Logger().i("QRCode scanner read: ${barcodeScanRes}");
      Toast.show(_scanned, context, duration: Toast.LENGTH_LONG);
      _tabController.index = 1;
    });
    // Navigator.of(context).pop();
  }

  Widget _qrcodegenerate(BuildContext context) {
    Logger().i("QR code created with info: ${dataToQR}");
    return Center(
        child: QrImage(
      data: dataToQR,
      version: QrVersions.auto,
      size: MediaQuery.of(context).size.width * 0.75,
      // embeddedImage: icon,
      embeddedImageStyle: QrEmbeddedImageStyle(size: Size(80, 80)),
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
}
