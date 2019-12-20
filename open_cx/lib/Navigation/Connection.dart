/// Connection between two [PointOfInterest]
class Connection {
  // double _weight
  /// Unique identification number
  final int _connectionId;
  /// Unique identification nunber of destination POI
  final int _destPointId;

  /// Constructor
  Connection(this._connectionId, this._destPointId);

  // double get weight => _weight;

  /// Getter member function for [_connectionId]
  /// returns an [int] indicating [Connection]'s ID
  int get connectionId => _connectionId;

  /// Getter member function for [_destPointId]
  /// returns an [int] indicating destination POI's ID
  int get destPointId => _destPointId;
}