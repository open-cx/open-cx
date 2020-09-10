import 'dart:async';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'package:glob/glob.dart';
import 'steps/add_languages.dart';
import 'steps/connected_people.dart';
import 'steps/count_socials.dart';
import 'steps/filters.dart';
import 'steps/languages_count.dart';
import 'steps/num_friends.dart';
import 'steps/num_people.dart';
import 'steps/remove_language.dart';
import 'steps/tap_button.dart';
import 'steps/navigation.dart';
import 'steps/text.dart';

Future<void> main() {
  final config = FlutterTestConfiguration()
    ..features = [Glob(r"test_driver/features/**.feature")]
    ..reporters = [ProgressReporter(), TestRunSummaryReporter()]
    ..stepDefinitions = [
      TapButtonNTimesStep(),
      NumFriendsStep(),
      FiltersStep(),
      ConnectedPeopleStep(),
      NumPeopleStep(),
      NavigationStep(),
      CountSocialsStep(),
      LanguagesCountStep(),
      AddLanguagesStep(),
      TextStep(),
      RemoveLanguageStep()
    ]
    ..restartAppBetweenScenarios = true
    ..targetAppPath = "test_driver/app.dart"
    ..exitAfterTestRun = true; // set to false if debugging to exit cleanly
  return GherkinRunner().execute(config);
}
