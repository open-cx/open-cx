import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class GivenITapButton extends Given1WithWorld<String, FlutterWorld> {

  GivenITapButton() : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

  @override
  Future<void> executeStep(String input1) async {
    final locator = find.byValueKey(input1);
    await FlutterDriverUtils.tap(world.driver, locator, timeout: timeout);
  }

  @override
  RegExp get pattern => RegExp(r"I tap the {string} button");

}