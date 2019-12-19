import 'dart:async';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart' as encrypt;

import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;

import 'package:http/http.dart' as http;


class Scanner extends StatefulWidget {
  @override
  ScannerState createState() => ScannerState();
}

class ScannerState extends State<Scanner> {
  Uint8List bytes = Uint8List(200);
  String barcode;

  void qrscanned(value) async {

    print(value);
    final key = encrypt.Key.fromLength(32);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final iv = encrypt.IV.fromLength(16);

    final decrypted = encrypter.decrypt(encrypt.Encrypted.fromBase64(value), iv: iv);

    print(decrypted);
    setState(() => this.barcode = decrypted + " can receive the goodie bag");

    //backend connection
  /*  var route = "http://localhost:3000/api/canDeliver/"+decrypted;
    final response = await http.get(route);

    if(response.statusCode == 200){
      setState(() => this.barcode = "You can deliver the goodie bag");
      var route = "http://localhost:3000/api/setDelivered/"+decrypted;
      await http.post(route);
    }
    else
      setState(() => this.barcode = "This participant has already received a goodie bag");*/

  }
  
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Qrcode Scanner Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 200,
                height: 200,
                child: Image.memory(bytes),
              ),
              Text('$barcode'),
              RaisedButton(onPressed: _scan, child: Text("Scan")),
            ],
          ),
        ),
      ),
    );
  }

  Future _scan() async {
    String barcode = await scanner.scan();
    qrscanned(barcode);
  }
}