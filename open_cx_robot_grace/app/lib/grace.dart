import 'dart:io';
import 'dart:ui';
import 'dart:math';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class BoardGame extends Game {
  Size screenSize;
  double tileSize;

  Socket socket;
  String ip;
  String command = "k0.000";
  String speed = "s0.000";
  String result = "k0.000s0.000";
  double maxVAngle = 0.5;
  double maxLSpeed = 1.5;

  BoardGame(String IPaddr) {
    ////print(IPaddr);
    initialize(IPaddr);
  }

  void initialize(String IPaddr) async {
    resize(await Flame.util.initialDimensions());
    socket = await Socket.connect(IPaddr, 8080);
    ip = IPaddr;
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.height / 9; // 9:16 ratio
  }

  @override
  void render(Canvas canvas) {
    if (screenSize == null) {
      print('Screen size null\n');
      return;
    }
    canvas.drawRect(
      Rect.fromLTWH(
        0,
        0,
        screenSize.width,
        screenSize.height,
      ),
      Paint()..color = Colors.lightBlue[900],
    );
  }

  @override
  void update(double t) {
    if (screenSize == null) {
      print('Screen size null\n');
      return;
    }
    result = command + speed;
    //print(result);
    if (socket != null) {
      socket.write(result);
      result = "k0.000s0.000";
    }
  }

  void angularVelChange(Offset offset) {
    double vAng = 0.0;
    double radAngle = atan2(offset.dy, offset.dx);
    command = "k";

    /*
     if (dragging) {
      double _radAngle = atan2(dragPosition.dy - backgroundRect.center.dy,
          dragPosition.dx - backgroundRect.center.dx);
      double vAng = 0.0;

      // Update playerShip's player rad angle
      game.grace.lastMoveRadAngle = _radAngle;
      print(_radAngle);
    */

    if (offset.dy == 0 && offset.dx == 0) {
      command = "k";
      vAng = 0.0;
    } else if (radAngle < (-15 / 32) * pi && radAngle > (-17 / 32) * pi) {
      command = "i";
      vAng = 0.0;
    } else if (radAngle <= (-1 / 32) * pi && radAngle >= (-15 / 32) * pi) {
      command = "o";
      vAng = (radAngle + (15 / 32) * pi) * maxVAngle * 4 / pi;
    } else if (radAngle < (1 / 32) * pi && radAngle > (-1 / 32) * pi) {
      command = "l";
      vAng = 0.5;
    } else if (radAngle <= (15 / 32) * pi && radAngle >= (1 / 32) * pi) {
      command = ".";
      vAng = (radAngle - (15 / 32) * pi) * maxVAngle * (-4) / pi;
    } else if (radAngle < (17 / 32) * pi && radAngle > (15 / 32) * pi) {
      command = ",";
      vAng = 0.0;
    } else if (radAngle <= (31 / 32) * pi && radAngle >= (17 / 32) * pi) {
      command = "m";
      vAng = (radAngle - 17 / 32 * pi) * maxVAngle * 4 / pi;
    } else if ((radAngle < pi && radAngle > (31 / 32) * pi) ||
        (radAngle < (-31 / 32) * pi && radAngle > (-1) * pi)) {
      command = "j";
      vAng = 0.5;
    } else if (radAngle <= (-17 / 32) * pi && radAngle >= (-31 / 32) * pi) {
      command = "u";
      vAng = (radAngle + 17 / 32 * pi) * maxVAngle * (-4) / pi;
    }

    command += vAng.toStringAsFixed(3);
  }

  void linearVelChange(Offset offset) {
    speed = "s";
    double speedMod;
    speedMod = maxLSpeed * (100 - offset.dy) / 200;
    speed += speedMod.abs().toStringAsFixed(3);
    print(speed);
  }
}
