import 'package:flutter_driver/flutter_driver.dart' as driver;
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class LanguagesCountStep extends Then1WithWorld<int, FlutterWorld> {
  @override
  Future<void> executeStep(int input1) async{
    final find = driver.find;
    await world.driver.scrollUntilVisible(find.byValueKey('profile-page'),
      find.byValueKey('programming_languages-field'),
      dyScroll: -500);
    for (int i = 0; i < input1; i++) {
      await world.driver.waitFor(find.byValueKey('programming_languages-$i'));
    }
    return null;
  }

  @override
  RegExp get pattern =>
      RegExp(r"I expect there to be {int} Programming Languages");
}
