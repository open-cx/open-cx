import 'package:open_cx/communio/model/app_state.dart';
import 'package:open_cx/communio/redux/action_creators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class FilterForm extends StatefulWidget {
  @override
  _FilterFormState createState() => _FilterFormState();
}

class _FilterFormState extends State<FilterForm> {
  static final _formKey = GlobalKey<FormState>();
  static final TextEditingController filterController = TextEditingController();
  final int minLines = 1;
  final int maxLines = 1;
  final String emptyText = "Please write a new filter";
  final String description = 'Write the new filter';

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Form(
        key: _formKey,
        child: new ListView(
          children: this.generateForm(context),
        ),
      ),
    );
  }

  List<Widget> generateForm(BuildContext context) {
    final List<Widget> formWidget = List();
    formWidget.add(getTextForm(context));
    formWidget.add(getSubmitButton(context));
    return formWidget;
  }

  Widget getTextForm(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          description,
          textAlign: TextAlign.left,
        ),
        Container(
          margin: new EdgeInsets.all(50),
          child: Card(
            child: TextFormField(
              controller: filterController,
              minLines: minLines,
              maxLines: maxLines,
              validator: (value) {
                if (value.isEmpty) return this.emptyText;
                return null;
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget getSubmitButton(BuildContext context) {
    return Container(
      child: RaisedButton(
        onPressed: () {
          if (_formKey.currentState.validate()) {
            StoreProvider.of<AppState>(context)
                .dispatch(addNewFilter(filterController.text));
          }
          filterController.clear();
          Navigator.of(context).pop(context);
        },
        child: Text('Submit'),
      ),
    );
  }
}
