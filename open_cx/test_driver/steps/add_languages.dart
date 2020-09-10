import 'package:flutter_driver/flutter_driver.dart' as driver;
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class AddLanguagesStep extends When1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String input1) async {
    final find = driver.find;
    final field = find.byValueKey('programming_languages-field');
    await world.driver.scrollUntilVisible(
        find.byValueKey('profile-page'), field,
        dyScroll: -500);
    await world.driver.tap(field);
    await world.driver.enterText(input1);
    await world.driver.tap(find.byValueKey('programming_languages-button'));
    return null;
  }

  @override
  RegExp get pattern => RegExp(r"I add {string} to the languages");
}
