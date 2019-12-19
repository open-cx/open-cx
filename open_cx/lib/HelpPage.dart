import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:qr_flutter/qr_flutter.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'dart:math';

import 'package:open_cx/QRScanner.dart';
import 'package:http/http.dart' as http;

class QRCode extends StatelessWidget {


  String getUserId()  {

    //backend call not made because when login works i will be able to extract the user id from there

    final userID = '1234';

    final key = encrypt.Key.fromLength(32);
    final iv = encrypt.IV.fromLength(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final encrypted = encrypter.encrypt(userID, iv: iv);
    return encrypted.base64;
  }

  bool selectedUser() {
    var rang = new Random();
    int rand = rang.nextInt(10);

    return (rand == 1);
  }

  bool checkInUser() {
    //backend request
    /*var userID="1234";
    var route = "http://localhost:3000/api/checkin/"+userID;
    final response = await http.get(route);

    if(response.statusCode == 200)
      return true;
    else
      return false;*/
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("<Programming> 2020"),
    ),
    body: checkInUser() ? Padding(
    padding: const EdgeInsets.all(8),
    child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
     Center(
            child: QrImage(
            data: getUserId(),
            version: QrVersions.auto,
            size: 200.0,
            backgroundColor: Colors.white,
          ),),
          selectedUser() ? Text("Our robot is on its way to deliver your goodies!")
              : Text("Use this QR Code to collect your goodies on the help desk"),
        ])));
  }
}



class HelpPage extends StatelessWidget {

  bool checkedIn() {

    //backend request
    /*var userID="1234";
    var route = "http://localhost:3000/api/verifyCheckedIn/"+userID;
    final response = await http.get(route);

    bool isCheckedIn;
    if(response.statusCode == 200)
      isCheckedIn = true;
    else
      isCheckedIn = false;
    return isCheckedIn;*/
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.all(8),
            child:  checkedIn() ? null : Column(children: <Widget>[
              Container(
                height: 80,

                child:  new FlatButton(
                          color: Colors.blue,
                          textColor: Colors.white,
                          padding: EdgeInsets.all(8.0),
                          splashColor: Colors.blueAccent,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => QRCode()),
                            );
                          },
                    child: Text(
                      "Check in and collect your goodies using a QRCode",
                      style: TextStyle(fontSize: 20.0),
                    ),
              )),
              Container(
                  height: 80,

                  child:  new FlatButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    padding: EdgeInsets.all(8.0),
                    splashColor: Colors.blueAccent,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Scanner()),
                      );
                    },
                    child: Text(
                      "Scan a QRCode",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  )),
            ]));
  }
}