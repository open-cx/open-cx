import 'package:flutter/material.dart';

class TextFieldForm extends StatefulWidget {
  final Function(String) callback;

  const TextFieldForm({Key key, @required this.callback}) : super(key: key);

  @override
  _TextFieldFormState createState() => _TextFieldFormState(callback);
}

class _TextFieldFormState extends State<TextFieldForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController fieldController = TextEditingController();

  final Function(String) callback;

  _TextFieldFormState(this.callback);
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        margin: EdgeInsets.only(top: 3, left: 15),
        child: Row(
          children: <Widget>[buildTextField(context), buildAddButton(context)],
        ),
      ),
    );
  }

  buildTextField(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.primary)),
      width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.height * 0.07,
      child: TextFormField(
        controller: fieldController,
      ),
    );
  }

  buildAddButton(BuildContext context) {
    return IconButton(
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
