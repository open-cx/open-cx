import 'package:flutter/cupertino.dart';

class CenterText extends StatelessWidget {
  final String text;
  final double textScale;

  CenterText(this.text, {this.textScale = 1.0});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(this.text, textScaleFactor: textScale, textAlign: TextAlign.center)
    );
  }
}