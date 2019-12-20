import 'dart:ui';

import 'package:flutter/material.dart';

import 'ThemeTalk.dart';

class User {

  String name;
  String email;
  List<ThemeTalk> preferredThemes;
  String photo;

  User(this.name, this.email, this.preferredThemes, this.photo);

  ImageProvider getImage() {
    return NetworkImage(this.photo);
  }



}