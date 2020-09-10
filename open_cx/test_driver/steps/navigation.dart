import 'package:flutter_driver/flutter_driver.dart' as driver;
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class NavigationStep extends Given1WithWorld<String, FlutterWorld>{
  @override
  Future<void> executeStep(String input1) async {
    final find = driver.find;
    await world.driver.tap(find.byTooltip("Open navigation menu"));
    await world.driver.tap(find.byValueKey(input1));
  }

  @override
  RegExp get pattern => RegExp(r"I head to the {string} page");

}