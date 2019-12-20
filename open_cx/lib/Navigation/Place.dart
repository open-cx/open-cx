class Place {
  /// Name of the event
  final String _name;
  /// Name of the room in which the event will take place
  final String _room;
  /// Integer indicating a POI in the map
  final int _poiId;

  Place(this._name, this._room, this._poiId);

  /// Getter member function for [_name]
  /// return a [String] with the name of the event
  String get name => _name;

  /// Getter member function for [_room]
  /// return a [String] with the name of the room for the event
  String get room => _room;

  /// Getter member function for [_poiId]
  /// return an [int] indicating the location of the Event
  int get poiId => _poiId;

  /// Factory constructor
  /// Returns a [Place] object given a json style [Map]
  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
        json['placeName'] as String,
        json['room'] as String,
        json['poiId'] as int
    );
  }
}