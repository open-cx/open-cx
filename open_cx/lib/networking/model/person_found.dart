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
    return PersonFound.fromJson(responseJson);
  }

  factory PersonFound.fromJson(Map<String, dynamic> json) {
        final List interests = new List();
        interests.addAll(json['tags']); 
        interests.addAll(json['skills']); 
        interests.addAll(json['programming_languages']); 
        return PersonFound(
        name: json['fullname'],
        photo: json['photo'],
        location: json['location'],
        interests: interests);
  }
}
