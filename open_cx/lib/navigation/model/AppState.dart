import 'package:open_cx/navigation/model/POIType.dart';
import 'package:open_cx/navigation/model/PointOfInterest.dart';

class AppState {
  Map content = Map<String, dynamic>();

  Map getInitialContent() {
    return {
      "pointsOfInterest" : new List<PointOfInterest>(),
      "poisStatus" : RequestStatus.NONE,
      "mapFilters" : new Map<POIType, bool>()
    };
  }

  AppState(Map content) {
    if (content != null) {
      this.content = content;
    } else {
      this.content = this.getInitialContent();
    }
  }

  AppState cloneAndUpdateValue(key, value) {
    return new AppState(Map.from(this.content)..[key] = value);
  }

  AppState cloneAndUpdateMapFilter(POIType filter, bool value) {
    Map<POIType, bool> newFilters = Map.from(this.content["mapFilters"])..[filter] = value;
    return new AppState(Map.from(this.content)..["mapFilters"] = newFilters);
  }

  AppState getInitialState() {
    return new AppState(null);
  }
}

enum RequestStatus {
  NONE, BUSY, FAILED, SUCCESSFUL
}