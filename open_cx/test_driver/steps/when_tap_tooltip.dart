import 'package:flutter_gherkin/src/flutter/flutter_world.dart';
import 'package:flutter_gherkin/src/flutter/utils/driver_utils.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:gherkin/gherkin.dart';


class WhenTapTooltip extends When1WithWorld<String, FlutterWorld> {
  @override
  RegExp get pattern => RegExp(
      r"I tap the {string} tooltip");

  @override
  Future<void> executeStep(String key) async {
    await FlutterDriverUtils.tap(world.driver, find.byTooltip(key),
        timeout: timeout * .9);
  }
}
