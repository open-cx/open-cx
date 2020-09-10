import 'package:flutter/material.dart';

class AppProgressIndicator extends StatefulWidget {
  @override
  _AppProgressIndicatorState createState() => _AppProgressIndicatorState();
}

class _AppProgressIndicatorState extends State<AppProgressIndicator>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.elasticIn,
    );

    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
        child: RotationTransition(
          turns: Tween(begin: 0.0, end: 5.0).animate(animationController),
          child: Container(
            height: size.height * 0.1,
            width: size.width * 0.5,
            child: FlutterLogo(),
          ),
        ),
      );
  }
}