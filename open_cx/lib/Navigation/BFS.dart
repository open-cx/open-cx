import 'dart:collection';

import 'Connection.dart';
import 'Graph.dart';
import 'PointOfInterest.dart';

/// Breadth-first search implementation
class BFS {
  /// Graph data structure containing all POIs
  final Graph _graph;
  /// a queue to maintain queue of POIs whose
  /// connection list is to be scanned as per normal
  /// BFS algorithm
  Queue<int> _queue;
  /// Visited POIs not to be repeated when performing
  /// breadth-first search
  HashMap<int, PointOfInterest> _visitedPoints;
  /// Each POI has a predecessor, which is another POI,
  /// when the final POI is found we can backtrack to the
  /// first POI with this HashMap and find the path
  HashMap<int, int> _predecessor;
  /// Contains the path from source POI to final POI
  List<int> _path;

  /// Constructor
  BFS(this._graph) {
    // initialize structures
    this._queue = new Queue<int>();
    this._visitedPoints = new HashMap<int, PointOfInterest>();
    this._path = new List<int>();
    this._predecessor = new HashMap<int, int>();
  }

  /// Getter member function for [_path]
  /// returns a [List] of [int] indicating the path from
  /// a POI to another
  List<int> get path => _path;

  /// Main member function to perform search and build path
  bool execute(int sourcePoint, int destinationPoint) {
    // perform search
    if (!this.performSearch(sourcePoint, destinationPoint)) {
      // search failed, there is no possible path
      return false;
    }
    // build path
    this.buildPath(sourcePoint, destinationPoint);
    return true;
  }

  /// Performs a breadth-first search, clear [_visitedPoints] and [queue],
  /// completes [path] with the POIs' IDs from source POI to final POI
  bool performSearch(int sourcePoint, int destinationPoint) {
    // clear queue and visited points
    this._visitedPoints.clear();
    this._queue.clear();
    this._path.clear();
    this._predecessor.clear();
    // add sourcePoint to visited points
    this.addVisited(sourcePoint);
    // queue sourcePoint so it is the next POI to be visited
    this._queue.add(sourcePoint);
    // main BFS algorithm
    while(this._queue.isNotEmpty) {
      // pop queue and get first element
      int currentPoint = this._queue.first;
      this._queue.removeFirst();
      // get POIs connections
      List<Connection> nextPointConnections = this._graph.getConnections(currentPoint);
      for (Connection connection in nextPointConnections) {
        // process unvisited POI
        if (!this.isVisited(connection.destPointId)) {
          // mark destination POI as visited
          this.addVisited(connection.destPointId);
          // add current POI to destination POI predecessor
          this._predecessor[connection.destPointId] = currentPoint;
          // add destination POI to queue
          this._queue.add(connection.destPointId);
          // stop BFS search when destination POI is found
          if (connection.destPointId == destinationPoint)
            return true;
        }
      }
    }
    return false;
  }

  /// After performSearch() is called we need to build path
  /// by backtracking from [destinationPoint] to [sourcePoint]
  /// going through all intermediate POIs and finally achieving
  /// the desired path
  void buildPath(int sourcePoint, int destinationPoint) {
    // add destination point to path
    this._path.add(destinationPoint);
    int auxPointId = destinationPoint;
    // backtrack to find path
    while(this._predecessor[auxPointId] != null) {
      // add predecessor to end of this list
      this._path.add(this._predecessor[auxPointId]);
      // get predecessor's predecessor
      auxPointId = this._predecessor[auxPointId];
    }
  }

  /// Detects if a POI was already visited, i.e, is it stored in
  /// [_visitedPoints], returns true if affirmative, false otherwise
  bool isVisited(int pointId) {
    return _visitedPoints.containsKey(pointId);
  }

  /// Adds POI with ID [pointID] to [_visitedPoints] so it cannot
  /// be visited again
  void addVisited(int pointId) {
    _visitedPoints[pointId] = _graph.getPointOfInterest(pointId);
  }


}