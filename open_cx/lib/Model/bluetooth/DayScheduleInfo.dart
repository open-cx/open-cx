import 'dart:collection';
import 'package:open_cx/constants/Dates.dart';
import 'package:open_cx/Model/bluetooth/Session.dart';

class DayScheduleInfo {
  DayScheduleInfo(int day, Date date) {
    this._day = day;
    this._date = date;
    this._sessions = SplayTreeSet();
  }

  DayScheduleInfo.withSessions(int day, Date date, SplayTreeSet<Session> sessions) {
    this._day = day;
    this._date = date;
    this._sessions = sessions;
  }

  int _day;
  Date _date;
  SplayTreeSet<Session> _sessions;

  SplayTreeSet<Session> getSessions() {
    return _sessions;
  }

  void setSessions(SplayTreeSet<Session> sessions) {
    this._sessions = sessions;
  }

  int getDay() {
    return _day;
  }

  Date getDate() {
    return _date;
  }
}
