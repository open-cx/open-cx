import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class GivenExpectedWidget extends Given2WithWorld<String, String, FlutterWorld> {

  GivenExpectedWidget() : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

  @override
  Future<void> executeStep(String input1, String input2) async {
    final locator = find.byValueKey(input1);
    switch(input2) {
      case "hidden":
        await FlutterDriverUtils.isAbsent(world.driver, locator, timeout: timeout);
        break;
      case "visible":
        await FlutterDriverUtils.isPresent(locator, world.driver, timeout: timeout);
        break;
    }
  }

  @override
  RegExp get pattern => RegExp(r"I expect the {string} to be (hidden|visible)");

}