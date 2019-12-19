import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';

class VenuePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.black,
        appBar: AppBar(
            backgroundColor: Colors.black,
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back_ios,
                  color: const Color(0xff66abbe)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Row(children: <Widget>[
              Text('<programming> 2020',
                  style: TextStyle(
                      fontSize: 22,
                      color: const Color(0xaaffffff),
                      shadows: <Shadow>[
                        Shadow(
                            offset: Offset(1.0, 1.0),
                            blurRadius: 3.0,
                            color: const Color(0xff66abbe)),
                        Shadow(
                            offset: Offset(-1.0, -1.0),
                            blurRadius: 3.0,
                            color: const Color(0xff66abbe))
                      ])),
              Image(image: AssetImage('assets/images/logo.png'))
            ])),
        body: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(children: <Widget>[
              Container(
                height: 130,
              ),
              Container(
                height: 80,
                child: const Center(
                    child: Text('Insert your email',
                        style: TextStyle(
                            fontSize: 22,
                            color: const Color(0xaaffffff),
                            shadows: <Shadow>[
                              Shadow(
                                  offset: Offset(1.0, 1.0),
                                  blurRadius: 3.0,
                                  color: const Color(0xff66abbe)),
                              Shadow(
                                  offset: Offset(-1.0, -1.0),
                                  blurRadius: 3.0,
                                  color: const Color(0xff66abbe))
                            ]))),
              ),
              Expanded(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text("Powered by",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: const Color(0xaaffffff),
                                  shadows: <Shadow>[
                                    Shadow(
                                        offset: Offset(1.0, 1.0),
                                        blurRadius: 3.0,
                                        color: const Color(0xff66abbe)),
                                    Shadow(
                                        offset: Offset(-1.0, -1.0),
                                        blurRadius: 3.0,
                                        color: const Color(0xff66abbe))
                                  ])),
                          Image(
                              image: AssetImage('assets/images/bitX.png'),
                              height: 50),
                        ]),
                  )),
            ])));
  }
}