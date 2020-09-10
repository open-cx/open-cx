import 'package:flutter_driver/flutter_driver.dart' as driver;
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class TextStep extends Then1WithWorld<String, FlutterWorld>{
  @override
  Future<void> executeStep(String input1) {
    driver.find.text(input1);
    return null;
  }

  @override
  RegExp get pattern => RegExp(r"I find the text {string}");

}