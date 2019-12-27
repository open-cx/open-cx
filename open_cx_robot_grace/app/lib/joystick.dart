import 'dart:math';
import 'package:flutter/material.dart';

class Joystick extends StatefulWidget {
  final void Function(Offset) onChange;

  const Joystick({
    Key key,
    @required this.onChange,
  }) : super(key: key);

  JoystickState createState() => JoystickState();
}

class JoystickState extends State<Joystick> {
  Offset delta = Offset.zero;
  double side = 50;

  void updateDelta(Offset newDelta) {
    widget.onChange(newDelta);
    setState(() {
      delta = newDelta;
    });
  }

  void calculateDelta(Offset offset) {
    Offset newDelta = offset - Offset(side / 2, side / 2);
    updateDelta(
      Offset.fromDirection(
        newDelta.direction,
        min(side / 2, newDelta.distance),
      ),
    );
  }

  Widget build(BuildContext context) {
    return SizedBox(
      height: side,
      width: side,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(90),
        ),
        child: GestureDetector(
          child: Container(
            decoration: BoxDecoration(
              color: Color(0x88ffffff),
              borderRadius: BorderRadius.circular(90),
            ),
            child: Center(
              child: Transform.translate(
                offset: delta,
                child: SizedBox(
                  height: 5 * side / 8,
                  width: 5 * side / 8,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      borderRadius: BorderRadius.circular(45),
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
    updateDelta(Offset.zero);
  }

  void onDragCancel() {
    updateDelta(Offset.zero);
  }
}
