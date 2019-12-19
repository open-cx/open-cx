import 'package:flutter/material.dart';
import '../constants/AppColors.dart' as AppColors;

class GenericContainer extends StatelessWidget {
  GenericContainer({this.title, this.text, this.touchable = false});

  final String title;
  final String text;
  final bool touchable;

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      width: deviceWidth * 0.95,
      decoration: BoxDecoration(
          color: AppColors.containerColor,
          borderRadius: BorderRadius.all(Radius.circular(18.0))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      title,
                      style: TextStyle(
                          color: AppColors.mainColor,
                          fontWeight: FontWeight.w900,
                          fontSize: 21),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  if (this.touchable)
                    Icon(Icons.search,
                        color: AppColors.mainColor, size: 32)
                ]),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(text,
                  style: TextStyle(
                      color: AppColors.mainColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
