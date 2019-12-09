import 'package:open_cx/communio/view/Widgets/profile_text_field.dart';
import 'package:flutter/material.dart';

class InsertEmailField extends StatefulWidget {
  final TextEditingController controller;
  InsertEmailField(this.controller);

  @override
  State<StatefulWidget> createState() {
    return _InsertEmailFieldState(this.controller);
  }
}

class _InsertEmailFieldState extends State<InsertEmailField> {
  static final emailRegex =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  final TextEditingController controller;
  _InsertEmailFieldState(this.controller);

  validation(value) {
    final checkVal = value.trim();
    if (checkVal.isEmpty) return 'Field is empty';
    if (!RegExp(emailRegex).hasMatch(checkVal))
      return 'Insert a valid e-mail address';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return ProfileTextField(
        validation: validation,
        name: 'Email',
        icon: Icons.email,
        controller: this.controller,
        inputType: TextInputType.emailAddress,);
  }
}
