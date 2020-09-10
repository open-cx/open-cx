import 'package:flutter_driver/flutter_driver.dart' as driver;
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class RemoveLanguageStep extends When1WithWorld<int, FlutterWorld> {
  @override
  Future<void> executeStep(int input1) async {
    final find = driver.find;
    await world.driver.scrollUntilVisible(find.byValueKey('profile-page'),
        find.byValueKey('programming_languages-field'),
        dyScroll: -500);
    await world.driver.scroll(find.byValueKey('programming_languages-$input1'),
        0, 0, Duration(seconds: 1));
    return null;
  }

  @override
  RegExp get pattern => RegExp(r"I remove Programming Language number {int}");
}
