import 'package:communio/model/person_found.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'known_person.dart';

class AppState {

  Map content = Map<String, dynamic>();

  Map getInitialContent() {
    return {
      "counter": 0,
      "scanning_on": false,
      "bluetooth_devices": Map<String, PersonFound>(),
      "friends": Set<KnownPerson>(),
      "current_filters": Set<String>(),
      "user_id": "5dd82f004073ad3bb92b80dc",
      "person_query_url": "http://www.mocky.io/v2/5da74a162f00002a003683f0",
      "current_device": "",
      "profile": '${DotEnv().env['API_URL']}users',
      "connected": '${DotEnv().env['API_URL']}users/matches',
      "friend_request": "${DotEnv().env['API_URL']}users/matches/requests"
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

  AppState getInitialState() {
    return new AppState(null);
  }

}
