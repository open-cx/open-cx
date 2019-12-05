import 'package:flutter_gherkin/src/flutter/flutter_world.dart';
import 'package:flutter_gherkin/src/flutter/utils/driver_utils.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:gherkin/gherkin.dart';

class WhenOpenNavigationMenu extends WhenWithWorld<FlutterWorld> {
  @override
  RegExp get pattern => RegExp(
      r"I open the navigation menu");

  @override
  Future<void> executeStep() async {
    await FlutterDriverUtils.tap(world.driver, find.byTooltip("Open navigation menu"),
        timeout: timeout * .9);
  }
}
