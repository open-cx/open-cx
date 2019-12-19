import 'package:flutter/material.dart';
import '../constants/AppColors.dart' as AppColors;

class GenericTitle extends StatelessWidget {
  GenericTitle({this.title, this.style, this.padding, this.margin,this.backgroundColor = AppColors.containerColor});

  final String title;
  final TextStyle style;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: this.padding,
        margin: this.margin,
        decoration: new BoxDecoration(
            color: this.backgroundColor,
            borderRadius: BorderRadius.circular(10.0)),
        child: Text(this.title, style: this.style));
  }
}
