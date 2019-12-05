import 'package:open_cx/guideasy_app/model/AppState.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

void generalMiddleware(
    Store<AppState> store,
    dynamic action,
    NextDispatcher next,
    ){
  if (action is ThunkAction<AppState>) {
    action(store);
  } else {
    next(action);
  }
}