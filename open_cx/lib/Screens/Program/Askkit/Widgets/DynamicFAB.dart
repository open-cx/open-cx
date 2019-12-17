import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DynamicFAB extends StatefulWidget {
  final ScrollController scrollController;
  final VoidCallback onPressed;

  DynamicFAB(this.scrollController, this.onPressed);

  @override
  State<StatefulWidget> createState() {
    return DynamicFABState();
  }

}

class DynamicFABState extends State<DynamicFAB> with TickerProviderStateMixin {
  double scale = 1;
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    animation = Tween<double>(begin: 0, end: 1).animate(controller);

    animation.addListener(() { setState(() { scale = animation.value; }); });
    widget.scrollController.addListener(() {
      ScrollDirection direction = widget.scrollController.position.userScrollDirection;
      if (direction == ScrollDirection.forward) // should be visible
        this.enableGrow();
      else if (direction == ScrollDirection.reverse) this.enableShrink();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void enableGrow() {
    if (controller.isAnimating || scale == 1)
      return;
    controller.forward(from: 0);
  }

  void enableShrink() {
    if (controller.isAnimating || scale == 0)
      return;
    controller.reverse(from: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
        scale: scale,
        child: FloatingActionButton(
            backgroundColor: Color(0xFF28316C),
            onPressed: widget.onPressed,
            child: Icon(Icons.add, color: Theme.of(context).canvasColor) //, size: size / 2),
        )
    );
  }


}

