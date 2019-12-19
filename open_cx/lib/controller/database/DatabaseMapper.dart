import 'dart:collection';
import 'package:open_cx/Model/bluetooth/Item.dart';
import 'package:open_cx/Model/bluetooth/Person.dart';
import 'package:open_cx/Model/bluetooth/Session.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseMapper {

  static Future<SplayTreeSet<Session>> getDaySessions(Database db, String date) async {
    var results = await db.rawQuery('SELECT * FROM Session WHERE day = ?', [date]);
    SplayTreeSet<Session> sessions = SplayTreeSet();
    for(int i = 0; i < results.length; i++) {
      Map<String, dynamic> sessionMap = results.elementAt(i);
      List<Map<String, dynamic>> sessionItemMap = await db.rawQuery('SELECT * FROM SessionItem WHERE sessionKey = ?', [sessionMap['sessionKey']]);
      List<Map<String, dynamic>> sessionChairMap = await db.rawQuery('SELECT * FROM SessionChair WHERE sessionKey = ?', [sessionMap['sessionKey']]);
      sessions.add(Session.fromMap(sessionMap, sessionItemMap, sessionChairMap));
    }
    return sessions;
  }

  static Future<List<Person>> getDaySpeakers(Database db, String date) async {

    var results = await db.rawQuery('SELECT DISTINCT personKey FROM Session JOIN SessionChair WHERE day = ?',[date]);

    List<String> keys = List<String>();

    for(int i = 0; i < results.length;i++){

      keys.add(results.elementAt(i)['personKey']);
    }

    List<Person> people = await getPeopleWithKeys(db,keys);

    return people;
  }


  static Future<SplayTreeSet<Session>> getSessionsInLocation(Database db, String location) async {
    var results = await db.rawQuery('SELECT * FROM Session WHERE location = ?', [location]);
    SplayTreeSet<Session> sessions = SplayTreeSet();
    for(int i = 0; i < results.length; i++) {
      Map<String, dynamic> sessionMap = results.elementAt(i);
      List<Map<String, dynamic>> sessionItemMap = await db.rawQuery('SELECT * FROM SessionItem WHERE sessionKey = ?', [sessionMap['sessionKey']]);
      List<Map<String, dynamic>> sessionChairMap = await db.rawQuery('SELECT * FROM SessionChair WHERE sessionKey = ?', [sessionMap['sessionKey']]);
      sessions.add(Session.fromMap(sessionMap, sessionItemMap, sessionChairMap));
    }
    return sessions;
  }


  static Future<List<String>> getLocationsByOrder(Database db) async {
    var results = await db.rawQuery('SELECT DISTINCT location FROM Session WHERE isCustom = 0 ORDER BY location COLLATE NOCASE ASC');
    List<String> locations = [];
    for(int i = 0; i < results.length; i++) {
      locations.add(results.elementAt(i)['location']);
    }
    return locations;
  }


  static Future<List<Person>> getPeopleWithKeys(Database db, List<String> keys) async {
    List<Person> people = [];
    for(int i = 0; i < keys.length; i++) {
      var results = await db.rawQuery('SELECT * FROM Person WHERE personKey = ?', [keys.elementAt(i)]);
      if (results.length > 0) {
        people.add(new Person.fromMap(results.first));
      }
    }
    return people;
  }

  static Future<List<Item>> getItemWithKeys(Database db, List<String> keys) async {
    List<Item> items = [];
    for(int i = 0; i < keys.length; i++) {
      var itemMap = await db.rawQuery('SELECT * FROM Item WHERE itemKey = ?', [keys.elementAt(i)]);
      List<Map<String, dynamic>> itemAuthorMap = await db.rawQuery('SELECT * FROM ItemAuthor WHERE itemKey = ?', [keys.elementAt(i)]);
      if(itemMap.length > 0) {
        items.add(Item.fromMap(itemMap.elementAt(0), itemAuthorMap));
      }
    }
    return items;
  }


  static Future<Session> getSession(Database db, String key) async {
    var sessionMap = await db.rawQuery('SELECT * FROM Session WHERE sessionKey = ?', [key]);
    List<Map<String, dynamic>> sessionItemMap = await db.rawQuery('SELECT * FROM SessionItem WHERE sessionKey = ?', [key]);
    List<Map<String, dynamic>> sessionChairMap = await db.rawQuery('SELECT * FROM SessionChair WHERE sessionKey = ?', [key]);
    if(sessionMap.length > 0) {
      return Session.fromMap(sessionMap.elementAt(0), sessionItemMap, sessionChairMap);
    }
    return null;
  }


  static Future<SplayTreeSet<Session>> getScheduleInfo(Database db, int day) async {
    var results = await db.rawQuery('SELECT * FROM ScheduleSession WHERE scheduleDay = ?', [day]);
    SplayTreeSet<Session> sessions = SplayTreeSet();
    for(int i = 0; i < results.length; i++) {
      sessions.add(await getSession(db, results.elementAt(i)['sessionKey']));
    }
    return sessions;
  }

  static Future<int> getScheduleDayFromDate(Database db, String date) async {
    var results = await db.rawQuery('SELECT scheduleDay FROM Schedule WHERE date = ?', [date]);
    return results[0]['scheduleDay'];
  }

  static Future<int> getLastUsedCustomSessionIDNum(Database db) async {
    var results = await db.rawQuery('SELECT count(*) as cnt FROM Session WHERE sessionKey LIKE "__AMA_Custom_Session_%"');

    return results[0]['cnt'];
  }

  static Future addSession(Database db,Session session) async {
    await db.insert('Session', session.toMapSession());
  }

  static Future removeSessionFromSchedule(Database db, int day, String sessionKey) async {
    await db.rawDelete('DELETE FROM ScheduleSession WHERE sessionKey = ? AND scheduleDay = ?', [sessionKey, day]);
  }


  static Future addSessionToSchedule(Database db, int day, String sessionKey) async {

    await db.rawInsert('INSERT INTO ScheduleSession(sessionKey, scheduleDay) VALUES (?, ?)', [sessionKey, day]);
  }

}