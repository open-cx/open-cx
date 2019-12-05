import 'package:open_cx/guideasy_app/model/AppState.dart';
import 'package:open_cx/guideasy_app/model/POIType.dart';
import 'package:open_cx/guideasy_app/model/PointOfInterest.dart';

class SavePOIsAction {
  List<PointOfInterest> pointsOfInterest;
  SavePOIsAction(this.pointsOfInterest);
}

class SavePOIsStatusAction {
  RequestStatus status;
  SavePOIsStatusAction(this.status);
}

class UpdateMapFilterAction {
  POIType type;
  bool selected;
  UpdateMapFilterAction(this.type, this.selected);
}

class UpdateMapFiltersAction {
  Map<POIType, bool> mapFilters;
  UpdateMapFiltersAction(this.mapFilters);
}