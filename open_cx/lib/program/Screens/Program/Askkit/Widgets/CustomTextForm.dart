import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TextAreaForm extends StatelessWidget {
  final String _hintText;
  final String _validatorError;
  final GlobalKey<FormState> formkey;
  final TextEditingController controller;
  final bool autofocus;


  TextAreaForm(this.formkey, this.controller, this._hintText, this._validatorError, {this.autofocus = false});

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formkey,
        child: TextFormField(
          autofocus: this.autofocus,
            textCapitalization: TextCapitalization.sentences,
            style: Theme.of(context).textTheme.body2.copyWith(fontWeight: FontWeight.normal),
            maxLines: null,
            keyboardType: TextInputType.multiline,
            controller: controller,
            decoration: InputDecoration(
              hintText: _hintText,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
            ),
            validator: (String value) {
              if (value.length == 0)
                return _validatorError;
              return null;
            }
        )
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String _hintText;
  final String _validatorError;
  final GlobalKey<FormState> formkey;
  final TextEditingController controller;
  final bool autofocus;


  CustomTextField(this.formkey, this.controller, this._hintText, this._validatorError, {this.autofocus = false});

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formkey,
        child: TextFormField(
            autofocus: this.autofocus,
            textCapitalization: TextCapitalization.sentences,
            style: Theme.of(context).textTheme.body2.copyWith(fontWeight: FontWeight.normal),
            controller: controller,
            decoration: InputDecoration(
              hintText: _hintText,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
            ),
            validator: (String value) {
              if (value.length == 0)
                return _validatorError;
              return null;
            }
        )
    );
  }
}
