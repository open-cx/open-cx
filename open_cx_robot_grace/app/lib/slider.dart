import 'dart:math';
import 'package:flutter/material.dart';

class MySlider extends StatefulWidget {
  final void Function(Offset) onChange;

  const MySlider({
    Key key,
    @required this.onChange,
  }) : super(key: key);

  MySliderState createState() => MySliderState();
}

class MySliderState extends State<MySlider> {
  Offset delta = Offset(0, 100);

  void updateDelta(Offset newDelta) {
    widget.onChange(newDelta);
    setState(() {
      delta = newDelta;
    });
  }

  void calculateDelta(Offset offset) {
    Offset newDelta = Offset(0.0, 100.0) - offset;
    if (newDelta.dy > 100) {
      newDelta = Offset(0, 100);
    } else if (newDelta.dy < -100) {
      newDelta = Offset(0, -100);
    }
    updateDelta(Offset(0, -newDelta.dy));
  }

  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 15,
      child: Container(
        decoration: BoxDecoration(),
        child: GestureDetector(
          child: Container(
            decoration: BoxDecoration(
              color: Color(0x88ffffff),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Container(
                child: Transform.translate(
                  offset: Offset(delta.dx, delta.dy),
                  child: Transform.scale(
                    scale: 1.75,
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          onPanDown: onDragDown,
          onPanUpdate: onDragUpdate,
          onPanEnd: onDragEnd,
          onPanCancel: onDragCancel,
        ),
      ),
    );
  }

  void onDragDown(DragDownDetails d) {
    calculateDelta(d.localPosition);
  }

  void onDragUpdate(DragUpdateDetails d) {
    calculateDelta(d.localPosition);
  }

  void onDragEnd(DragEndDetails d) {
    //updateDelta(Offset.zero);
  }

  void onDragCancel() {
    updateDelta(Offset.zero);
  }
}
