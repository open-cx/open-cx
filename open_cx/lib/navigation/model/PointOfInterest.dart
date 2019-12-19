import 'package:open_cx/navigation/model/POIType.dart';

class PointOfInterest {
  int id;
  double latitude;
  double longitude;
  String title;
  String description;
  String keyword;
  POIType type;
  String floors;

  PointOfInterest(
    this.id,
    this.latitude,
    this.longitude,
    this.title,
    this.description,
    this.keyword,
    this.type,
    this.floors
  );

  factory PointOfInterest.fromJson(int id, Map<String, dynamic> parsedJson) {
    return PointOfInterest(
      id,
      parsedJson['latitude'] as double,
      parsedJson['longitude'] as double,
      parsedJson['title'] as String,
      parsedJson['description'] as String,
      parsedJson['keyword'] as String,
      stringToPOIType(parsedJson['type']),
      parsedJson['floors'] as String
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'latitude' : latitude,
      'longitude' : longitude,
      'title': title,
      'description' : description,
      'keyword' : keyword,
      'type' : type.index,
      'floors' : floors
    };
  }

}