import 'package:flutter_driver/flutter_driver.dart' as driver;
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class CountSocialsStep extends Then1WithWorld<int, FlutterWorld>{
  @override
  Future<void> executeStep(int input1) async {
    final find = driver.find;

    for(int i = 0; i < input1; i++){
      await world.driver.waitFor(find.byValueKey('social-block-$i'));
    }
    return null;
  }

  @override
  RegExp get pattern => RegExp(r"I expect there to be {int} social medias");

}