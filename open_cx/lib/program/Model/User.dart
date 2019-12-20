import 'dart:ui';

import 'package:flutter/material.dart';

import 'ThemeTalk.dart';

class User {

  String uid;
  String name;
  String email;
  List<ThemeTalk> preferredThemes;
  String photo;

  User({this.name, this.email, this.preferredThemes, this.photo, this.uid});

  ImageProvider getImage() {
    return NetworkImage(this.photo);
  }

}