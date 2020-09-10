import 'package:flutter_driver/flutter_driver.dart' as driver;
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class NumFriendsStep extends Then1WithWorld<int, FlutterWorld> {
  @override
  Future<void> executeStep(int input1) async {
    final find = driver.find;
    await FlutterDriverUtils.waitForFlutter(world.driver);
    for (int i = 0; i < input1; i++) {
      await FlutterDriverUtils.isPresent(
          find.byValueKey('friend-card-$i'), world.driver);
    }
  }

  @override
  RegExp get pattern => RegExp(r"I expect there to be {int} friends");
}
