import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:open_cx/networking/model/app_state.dart';

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