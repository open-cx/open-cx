import 'package:flutter_driver/flutter_driver.dart' as driver;
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class ConnectedPeopleStep extends Then1WithWorld<int, FlutterWorld> {
  @override
  Future<void> executeStep(int input1) {
    for(int i = 0; i < input1; i++){
      FlutterDriverUtils.isPresent(
              driver.find.byValueKey('person-card-$i'), world.driver);
    }
    return null;
  }

  @override
  RegExp get pattern => RegExp(r"I should have {int} people displayed");
}
