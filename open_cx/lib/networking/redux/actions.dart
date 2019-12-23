import 'package:open_cx/networking/model/app_state.dart';
import 'package:open_cx/networking/model/known_person.dart';
import 'package:open_cx/networking/model/person_found.dart';
import 'package:logger/logger.dart';

abstract class ReduceableAction {
  AppState reduceAction(AppState state);
}

class IncrementCounterAction implements ReduceableAction {
  final int counter;
  IncrementCounterAction(this.counter);

  @override
  reduceAction(AppState state) {
    Logger().i('setting counter to ${counter}');
    return state.cloneAndUpdateValue('counter', counter);
  }
}

class FoundPersonAction implements ReduceableAction {
  final String uuid;
  final User personFound;
  FoundPersonAction(this.uuid, this.personFound);

  @override
  reduceAction(AppState state) {
    Logger().i('Adding a new person of '
        'id ${uuid} and name ${personFound.name}');
    final Map<String, User> bluetoothDevices =
        state.content['bluetooth_devices'];
    bluetoothDevices.putIfAbsent(uuid, () => personFound);
    return state.cloneAndUpdateValue('bluetooth_devices', bluetoothDevices);
  }
}

class RemovePersonAction implements ReduceableAction{
  final String uuid;
  RemovePersonAction(this.uuid);

  @override
  AppState reduceAction(AppState state) {
    final Map<String, User> bluetoothDevices =
    state.content['bluetooth_devices'];
    bluetoothDevices.remove(uuid);
    return state.cloneAndUpdateValue('bluetooth_devices', bluetoothDevices);
  }

}

class QueriedFriendsAction implements ReduceableAction {
  final Set<KnownPerson> friends;
  QueriedFriendsAction(this.friends);

  @override
  reduceAction(AppState state) {
    Logger().i('Found ${friends.length} friends:'
        '${friends}');
    return state.cloneAndUpdateValue('friends', friends);
  }
}

class NewFiltersAction implements ReduceableAction {
  final Set<String> filters;
  NewFiltersAction(this.filters);

  @override
  reduceAction(AppState state) {
    Logger().i('Filters are now ${filters}');
    return state.cloneAndUpdateValue('current_filters', filters);
  }
}

class ActivateScanning implements ReduceableAction {
  @override
  reduceAction(AppState state) {
    return state.cloneAndUpdateValue('scanning_on', true);
  }
}

class SelectActiveDevice implements ReduceableAction {
  final String deviceId;

  SelectActiveDevice(this.deviceId);

  @override
  AppState reduceAction(AppState state) {
    Logger().i('Added $deviceId as new device');
    return state.cloneAndUpdateValue('current_device', deviceId);
  }
}
