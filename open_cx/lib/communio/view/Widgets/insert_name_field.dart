import 'package:open_cx/communio/view/Widgets/profile_text_field.dart';
import 'package:flutter/material.dart';

class InsertNameField extends StatefulWidget {
  final TextEditingController controller;
  InsertNameField(this.controller);

  @override
  State<StatefulWidget> createState() {
    return _InsertNameFieldState(this.controller);
  }
}

class _InsertNameFieldState extends State<InsertNameField> {
  final TextEditingController controller;

  _InsertNameFieldState(this.controller);

  validation(value) {
    if (value.trim().isEmpty) return 'Field is empty';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return ProfileTextField(
        validation: validation,
        name: 'Name',
        icon: Icons.person,
        controller: this.controller);
  }
}
