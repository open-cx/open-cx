import 'package:communio/model/known_person.dart';
import 'package:flutter/foundation.dart';

class FriendRequest{
  final String id;
  final KnownPerson user;
  FriendRequest({
    @required this.id,
    @required this.user
  });

  factory FriendRequest.fromJson(Map<String, dynamic> json) {
    return FriendRequest(
      id: json['id'],
      user: KnownPerson.fromJson(json['user'])
    );
  }
}