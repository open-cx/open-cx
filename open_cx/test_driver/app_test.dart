import 'dart:async';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'package:glob/glob.dart';

import 'hooks/InfoHook.dart';
import 'steps/given_I_tap_button.dart';
import 'steps/given_expected_widget.dart';
import 'steps/then_expect_widget.dart';
import 'steps/when_open_navigation_menu.dart';
import 'steps/when_tap_tooltip.dart';

Future<void> main() {
  final config = FlutterTestConfiguration()
    ..features = [Glob(r"test_driver/features/**.feature")]
    ..reporters = [
      ProgressReporter(),
      TestRunSummaryReporter(),
      JsonReporter(path: './report.json')
    ] // you can include the "StdoutReporter()" without the message level parameter for verbose log information
    ..hooks = [InfoHook()]
    ..stepDefinitions = [
      GivenExpectedWidget(),
      ThenExpectWidget(),
      GivenITapButton(),
      WhenOpenNavigationMenu(),
      WhenTapTooltip()
    ]
    ..restartAppBetweenScenarios = true
    ..targetAppPath = "test_driver/app.dart"
    ..exitAfterTestRun = true; // set to false if debugging to exit cleanly
  return GherkinRunner().execute(config);
}