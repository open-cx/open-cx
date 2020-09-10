import 'package:flutter/material.dart';

class TextFieldForm extends StatefulWidget {
  final Function(String) callback;
  final String type;

  const TextFieldForm({Key key, @required this.callback, this.type})
      : super(key: key);

  @override
  _TextFieldFormState createState() => _TextFieldFormState(callback, type);
}

class _TextFieldFormState extends State<TextFieldForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController fieldController = TextEditingController();

  final Function(String) callback;
  final String type;

  _TextFieldFormState(this.callback, this.type);
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        margin: EdgeInsets.only(top: 3, left: 23),
        child: Row(
          children: <Widget>[buildTextField(context), buildAddButton(context)],
        ),
      ),
    );
  }

  buildTextField(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              color: Theme.of(context).colorScheme.primary, width: 1.1)),
      width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.height * 0.07,
      child: TextFormField(
        key: Key('$type-field'),
        controller: fieldController,
      ),
    );
  }

  buildAddButton(BuildContext context) {
    return IconButton(
      key: Key('$type-button'),
      color: Theme.of(context).colorScheme.primary,
      icon: Icon(Icons.add),
      onPressed: () {
        if (_formKey.currentState.validate() &&
            fieldController.text.isNotEmpty) {
          callback(fieldController.text);
        }
        fieldController.clear();
      },
    );
  }
}
