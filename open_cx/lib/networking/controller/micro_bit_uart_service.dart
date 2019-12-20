
import 'dart:async';

import 'package:flutter_blue/flutter_blue.dart';



class MicroBitUARTservice {

  BluetoothService uartService;
  BluetoothCharacteristic txCharacteristic;
  BluetoothCharacteristic rxCharacteristic;

  static const String UARTserviceUUID = '6E400001-B5A3-F393-E0A9-E50E24DCCA9E';
  static const String TXcharacteristicUUID = '6E400002-B5A3-F393-E0A9-E50E24DCCA9E';
  static const String RXcharacteristicUUID = '6E400003-B5A3-F393-E0A9-E50E24DCCA9E';
  static const int IdFlag = 36; //$
  static const int FinishFlag = 35; //#
  StreamSubscription subscription;

  MicroBitUARTservice(BluetoothService uartService) {
    this.uartService = uartService;
    _setCharacteristics();
  }

  static String getUUID() {
    return UARTserviceUUID;
  }

   void _setCharacteristics() {
    List<BluetoothCharacteristic> characteristics =
        this.uartService.characteristics;

    for (BluetoothCharacteristic c in characteristics) {
      if (c.uuid.toString().toUpperCase() == TXcharacteristicUUID) {
        this.txCharacteristic = c;
      } else if (c.uuid.toString().toUpperCase() == RXcharacteristicUUID) {
        this.rxCharacteristic = c;
      }
    }
  }

  void subscribe(Function onData) {
    this.txCharacteristic.setNotifyValue(true);
    subscription = this.txCharacteristic.value.listen(onData);
  }

  void unsubscribe() {
    subscription.cancel();
  }

  Future<void> write(int value) async {
    await this.rxCharacteristic.write(_encode(value));
  }

  List<int> _encode(int value) {
    List<int> byteArray = new List<int>();

    byteArray.addAll(value.toString().codeUnits);
    byteArray.add(IdFlag);

    return byteArray;
  }
  
}