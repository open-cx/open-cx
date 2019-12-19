import 'package:flutter/material.dart';

class BorderTop extends Border {
  BorderTop(Color color, double thickness) : super(
      top: BorderSide(color: color, width: thickness)
  );
}

class BorderLeft extends Border {
  BorderLeft(Color color, double thickness) : super(
      left: BorderSide(color: color, width: thickness)
  );
}

class BorderRight extends Border {
  BorderRight(Color color, double thickness) : super(
      right: BorderSide(color: color, width: thickness)
  );
}

class BorderBottom extends Border {
  BorderBottom(Color color, double thickness) : super(
      bottom: BorderSide(color: color, width: thickness)
  );
}