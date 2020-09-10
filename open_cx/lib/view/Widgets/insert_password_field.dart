import 'package:communio/view/Widgets/profile_text_field.dart';
import 'package:flutter/material.dart';

class InsertPasswordField extends StatefulWidget {
  final TextEditingController controller;
  InsertPasswordField(this.controller);

  @override
  State<StatefulWidget> createState() {
    return _InsertPasswordFieldState(this.controller);
  }
}

class _InsertPasswordFieldState extends State<InsertPasswordField> {
  final TextEditingController controller;
  _InsertPasswordFieldState(this.controller);

  validationFirst(value) {
    if (value.trim().isEmpty) return 'Field is empty';
    return null;
  }

  validationSecond(value) {
    if (!(controller.text.trim() == value.trim()))
      return 'Passwords don\'t match!';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ProfileTextField(
            validation: validationFirst,
            name: 'Password',
            icon: Icons.lock,
            sensitive: true,
            controller: controller),
        ProfileTextField(
            validation: validationSecond,
            name: 'Confirm Password',
            icon: Icons.lock,
            sensitive: true),
      ],
    );
  }
}
