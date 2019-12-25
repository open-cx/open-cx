import '../model/app_state.dart';
import 'actions.dart';

AppState appReducers(AppState state, dynamic action) {
  if (action is ReduceableAction) {
    return action.reduceAction(state);
  }
  return state;
}
