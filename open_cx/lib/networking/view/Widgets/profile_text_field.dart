import 'package:flutter/material.dart';

class ProfileTextField extends StatelessWidget {
  final Function validation;
  final String name;
  final IconData icon;
  final bool sensitive;
  final TextEditingController controller;
  final TextInputType inputType;

  ProfileTextField(
      {@required this.validation,
      @required this.name,
      @required this.icon,
      this.sensitive = false,
      this.controller = null,
      this.inputType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: TextFormField(
        controller: this.controller,
        validator: (value) {
          return validation(value);
        },
        keyboardType: inputType,
        obscureText: sensitive,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Theme.of(context).colorScheme.primaryVariant,
          ),
          hintText: name,
          hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.primaryVariant,
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Theme.of(context).buttonColor,
            width: 1.5,
            style: BorderStyle.solid,
          )),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.onSurface,
              width: 1.5,
              style: BorderStyle.solid,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.error,
              width: 1.5,
              style: BorderStyle.solid,
            ),
          ),
        ),
        maxLines: 1,
      ),
    );
  }
}
