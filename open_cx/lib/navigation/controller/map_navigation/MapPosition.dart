import 'dart:math' as math;

class MapPosition {
  final double latitude, longitude;

  MapPosition(this.latitude, this.longitude);

  // in meters
  // extracted from https://www.geeksforgeeks.org/program-distance-two-points-earth/
  double distanceTo(final MapPosition position) {
    // Convert from degrees to radians
    double lat1 = toRadians(this.latitude);
    double long1 = toRadians(this.longitude);
    double lat2 = toRadians(position.latitude);
    double long2 = toRadians(position.longitude);

    // Haversine formula
    double dlong = long2 - long1;
    double dlat = lat2 - lat1;
    double ans = math.pow(math.sin(dlat/2), 2) +
                  math.cos(lat1) * math.cos(lat2) *
                  math.pow(math.sin(dlong/2), 2);

    ans = 2 * math.asin(math.sqrt(ans));

    // Earth's radius in meters
    final double R = 6371000;
    return ans * R;
  }
}

double toRadians(final double degree) {
  return degree * math.pi / 180;
}