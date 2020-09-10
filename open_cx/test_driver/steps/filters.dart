import 'package:flutter_driver/flutter_driver.dart' as driver;
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class FiltersStep extends Given1WithWorld<Table, FlutterWorld> {
  @override
  Future<void> executeStep(Table input1) async {
    final columns = input1.asMap();
    final find = driver.find;
    final filters = columns.map((filter) => filter['filter']);
    await world.driver.tap(find.byTooltip("Open navigation menu"));
    await FlutterDriverUtils.tap(
        world.driver, find.byValueKey('ListConnected'));
    filters.forEach((filter) async{
      await world.driver.tap(find.byValueKey('filter-button'));
      await world.driver.tap(find.byValueKey('form-textfield'));
    await world.driver.enterText(filter);
      await world.driver.tap(find.byValueKey('form-submit'));
      await FlutterDriverUtils.waitForFlutter(world.driver);
    });
  }

  @override
  RegExp get pattern => RegExp(r"the following filters");
}
