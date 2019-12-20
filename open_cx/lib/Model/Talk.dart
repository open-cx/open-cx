import 'dart:ui';

import 'package:flutter/material.dart';

import 'ThemeTalk.dart';

class Talk {
  int id; //eventually can be changed with id from the database
  DateTime dateInitial;
  DateTime dateFinal;
  String name;
  String information;
  bool selected;
  bool notify;
  List<String> speakers = new List<String>();
  String location = "";
  List<ThemeTalk> themes = new List<ThemeTalk>();

  Talk(this.id,this.dateInitial, this.dateFinal, this.name, this.information,
      this.location, this.selected, this.notify,this.speakers, this.themes);

  void addSpeaker(String speaker){

    this.speakers.add(speaker);
  }

  Color getColor(){
    if (themes.length == 0)
      return Color(0xFF000000);

    return themes[0].color;
  }

  void turnOffNotification(){
    this.notify = false;
  }
}