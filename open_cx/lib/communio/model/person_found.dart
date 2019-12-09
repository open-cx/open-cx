import 'dart:convert';

import 'package:http/http.dart' as http;

class PersonFound {
  final String name;
  final String photo;
  final String location;
  final String description;
  final List<dynamic> interests;
  PersonFound(
      {this.name, this.photo, this.location, this.interests, this.description});

  static Future<PersonFound> fromNetwork(String url) async {
    final response = await http.get(url);
    final responseJson = json.decode(utf8.decode(response.bodyBytes));
    return PersonFound(
        name: responseJson['name'],
        photo: responseJson['photo'],
        location: responseJson['location'],
        interests: responseJson['interests']);
  }
}
