import 'package:flutter/cupertino.dart';

class RunningAnimation extends StatefulWidget {

  final double begin;
  final double end;
  final int duration;
  final double width;
  final double height;
  final VoidCallback animationCallback;

  RunningAnimation({
    Key key,
    this.begin = -100,
    this.end = 100,
    this.width = 100,
    this.height = 100,
    this.duration = 1,
    this.animationCallback,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => RunningAnimationState();
}

class RunningAnimationState extends State<RunningAnimation> with SingleTickerProviderStateMixin{

  AnimationController _controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(
          seconds: widget.duration),
      vsync: this,
    )..addListener(() =>
        setState(() {}));
    
    _controller.addStatusListener((status) {
      if(status == AnimationStatus.completed && widget.animationCallback != null) {
        widget.animationCallback();
      }
    });

    animation = Tween(begin: widget.begin, end: widget.end).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      child: Image(
        image: AssetImage('assets/guideasy_app/splash_screen/running_gif.gif'),
        width: widget.width,
        height: widget.height,
      ),
      offset: Offset(animation.value, 0.0),
    );
  }

}