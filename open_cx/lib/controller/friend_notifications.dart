import 'dart:convert';

import 'package:communio/model/known_person.dart';
import 'package:communio/view/Pages/profile_page.dart';
import 'package:communio/view/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;

void setupNotifications(String profileId) {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();
  final initializationSettingsAndroid =
      new AndroidInitializationSettings('icon');
  final initializationSettingsIOS = IOSInitializationSettings();
  final initializationSettings = InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);

  flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    Logger().i(payload);

    if (payload == 'friend_request') {
      await NavigationService.navigatorKey.currentState
          .pushNamed('/Friend Requests');
    } else {
      NavigationService.navigatorKey.currentState.push(MaterialPageRoute(
          builder: (context) => ProfilePage(
                profileId: payload,
                edit: false,
            )
          )
        );
    }
  });

  addFriendsEventListener(profileId, flutterLocalNotificationsPlugin);
}

void addFriendsEventListener(String profileId,
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) {
  final IO.Socket socket = IO.io(DotEnv().env['API_URL'], <String, dynamic>{
    'transports': ['websocket'],
    'extraHeaders': {'user_id': profileId}
  });

  socket.on('success', (_) {
    Logger().i('Sucessfully connected to Socket');
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    final iOSPlatformChannelSpecifics = IOSNotificationDetails();
    final platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    socket.on('friend_request', (data) async {
      await flutterLocalNotificationsPlugin.show(0, 'New Friend Request!',
          '$data wants to be your friend!', platformChannelSpecifics,
          payload: 'friend_request');
    });

    socket.on('friend_accepted', (data) async {
      final response =
          await http.get('${DotEnv().env['API_URL']}users/$data');
      final map = json.decode(utf8.decode(response.bodyBytes));
      final user = KnownPerson.fromJson(map).name;
      await FlutterLocalNotificationsPlugin().show(0, 'New Friend!',
          '$user accepted your friend request', platformChannelSpecifics,
          payload: data);
    });
  });
}
