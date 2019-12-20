import 'dart:async';
import 'dart:core';

import 'package:flutter_blue/flutter_blue.dart';

import 'micro_bit_uart_service.dart';

class MicroBit {
  //RECEBER A STORE
  static const int scanDuration = 2;
  static const int maxNumTries = 100;

  static final FlutterBlue flutterBlue = FlutterBlue.instance;
  BluetoothDevice microbit;
  MicroBitUARTservice uartService;

  bool connected;

  MicroBit() {
    this.connected = false;
  }

  Future<bool> connect(String deviceName) async {
    // Start scanning
    //TO DO
   // if(scanning_on is false on the store)
      flutterBlue.startScan(timeout: Duration(seconds: scanDuration));

    int numTries = 0;
    bool found = false;
    // Listen to scan results

    await for (List<ScanResult> scanResult in flutterBlue.scanResults) {
      print('Received scan results (Length: ${scanResult.length})');

      numTries++;
      for (ScanResult result in scanResult) {
        print('Analysing scan result: ${result.device.name}');
        if (_checkDeviceName(result.device.name, deviceName) && !found && !this.connected) {
          found = true;
          this.microbit = result.device;
          break;
        }
      }

      if (found || numTries >= maxNumTries) {
        break;
      }
    }

    // Stop scanning TO DO
//    if(scanning_on is false on the store)
//      flutterBlue.stopScan();

    if (found) {
      print('Moving to MB');
      bool connected = await _connectDevice();
      if (connected) {
        await _setUartService();
        this.connected = true;
      }
    }

    print('This.connected is ' + this.connected.toString());
    return this.connected;
  }

  bool _checkDeviceName(String deviceName, String expectedName) {
    return deviceName == 'BBC micro:bit [' + expectedName + ']';
  }

  Future<bool> _connectDevice() async {
    Future<bool> returnValue;
    await this.microbit.connect(autoConnect: false).timeout(Duration(seconds: 5), onTimeout: () {
      print('Timeout ocurred');
      returnValue = Future.value(false);
      this.microbit.disconnect();
    }).then((data) {
      if(returnValue == null)
        returnValue = Future.value(true);
    });

    return returnValue;
  }

  Future<void> _setUartService() async {
    List<BluetoothService> services = await this.microbit.discoverServices();

    services.forEach((service) {
      if (service.uuid.toString().toUpperCase() ==
          MicroBitUARTservice.getUUID()) {
        this.uartService = new MicroBitUARTservice(service);
      }
    });
  }

  bool isConnected() {
    return this.connected;
  }

  Future<void> disconnect() async {
    if (this.microbit != null) {
      this.uartService.unsubscribe();
      await this.microbit.disconnect();
      this.microbit = null;
      this.connected = false;
    }
  }

  Future<void> writeTo(int value) async {
    await this.uartService.write(value);
    print('Sent ' + value.toString() + ' to Micro:bit');
  }

  void subscribe(Function onData) {
    this.uartService.subscribe(onData);
  }
}
