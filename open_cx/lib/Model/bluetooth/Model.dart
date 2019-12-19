import 'dart:collection';

import 'package:open_cx/Model/bluetooth/Session.dart';

import 'DayScheduleInfo.dart';
import '../../constants/Dates.dart' as Dates;

class Model {

  List<DayScheduleInfo> _schedules = [];
  String _jsonURL;

  Model() {
    _schedules.add(DayScheduleInfo(1, Dates.date1));
    _schedules.add(DayScheduleInfo(2, Dates.date2));
    _schedules.add(DayScheduleInfo(3, Dates.date3));
    _schedules.add(DayScheduleInfo(4, Dates.date4));
  }

  void setScheduleSessions(SplayTreeSet<Session> schedule1, SplayTreeSet<Session> schedule2, SplayTreeSet<Session> schedule3, SplayTreeSet<Session> schedule4) {
    _schedules.elementAt(0).setSessions(schedule1);
    _schedules.elementAt(1).setSessions(schedule2);
    _schedules.elementAt(2).setSessions(schedule3);
    _schedules.elementAt(3).setSessions(schedule4);
  }

  List<DayScheduleInfo> getSchedules() {
    return _schedules;
  }

  void setJsonURL(String url) {
    _jsonURL = url;
  }

  String getJsonURL() {
    return _jsonURL;
  }

  void resetAllSchedules() {
    _schedules = [];
    _schedules.add(DayScheduleInfo(1, Dates.date1));
    _schedules.add(DayScheduleInfo(2, Dates.date2));
    _schedules.add(DayScheduleInfo(3, Dates.date3));
    _schedules.add(DayScheduleInfo(4, Dates.date4));
  }
}