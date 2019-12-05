import 'package:open_cx/guideasy_app/model/AppState.dart';

import 'Actions.dart';

AppState appReducers(AppState state, dynamic action) {
  if (action is SavePOIsAction) {
    return setPointsOfInterest(state, action);
  }
  else if (action is SavePOIsStatusAction) {
    return setPOIsStatus(state, action);
  }
  else if (action is UpdateMapFilterAction) {
    return setMapFilter(state, action);
  }
  else if (action is UpdateMapFiltersAction) {
    return updateMapFilters(state, action);
  }
  return state;
}

AppState setPointsOfInterest(AppState state, SavePOIsAction action) {
  print('setting points of interest');
  return state.cloneAndUpdateValue('pointsOfInterest', action.pointsOfInterest);
}
AppState setPOIsStatus(AppState state, SavePOIsStatusAction action) {
  print('setting POIs status: ' + action.status.toString());
  return state.cloneAndUpdateValue('poisStatus', action.status);
}

AppState setMapFilter(AppState state, UpdateMapFilterAction action) {
  print('setting ' + action.type.toString() + ' filter to ' + action.selected.toString());
  return state.cloneAndUpdateMapFilter(action.type, action.selected);
}

AppState updateMapFilters(AppState state, UpdateMapFiltersAction action) {
  print('updating map filters');
  return state.cloneAndUpdateValue('mapFilters', action.mapFilters);
}