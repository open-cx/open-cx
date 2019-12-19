import 'dart:collection';
import 'package:open_cx/Model/bluetooth/Session.dart';

class ListSessionsInfo {
  ListSessionsInfo(String title, SplayTreeSet<Session> sessions) {
    this._title = title;
    this._sessions = sessions;
  }

  String _title;
  SplayTreeSet<Session> _sessions;

  String getTitle() {
    return this._title;
  }


  SplayTreeSet<Session> getSessions() {
    return this._sessions;
  }
}