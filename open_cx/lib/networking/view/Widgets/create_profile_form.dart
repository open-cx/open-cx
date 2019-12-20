import 'package:open_cx/networking/view/Widgets/image_upload.dart';
import 'package:open_cx/networking/view/Widgets/insert_email_field.dart';
import 'package:open_cx/networking/view/Widgets/insert_name_field.dart';
import 'package:open_cx/networking/view/Widgets/insert_password_field.dart';
import 'package:open_cx/networking/view/Widgets/profile_interests.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:toast/toast.dart';

class CreateProfileForm extends StatefulWidget {
  @override
  CreateProfileFormState createState() {
    return CreateProfileFormState();
  }
}

class CreateProfileFormState extends State<CreateProfileForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _agreedToTOS = false;

  final List interests = new List();
  final List programmingLanguages = new List();
  final List skills = new List();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: ImageUpload()),
              InsertNameField(nameController),
              InsertEmailField(emailController),
              InsertPasswordField(passwordController),
              ProfileInterests(
                type: 'tags',
                interests: interests,
                edit: true,
                name: 'Interests',
              ),
              ProfileInterests(
                type: 'programming_languages',
                interests: programmingLanguages,
                edit: true,
                name: 'Programming Languages',
              ),
              ProfileInterests(
                type: 'skills',
                interests: skills,
                edit: true,
                name: 'Skills',
              ),
              buildTOSCheckbox(),
              buildSubmitButton(),
            ]));
  }

  buildTOSCheckbox() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: GestureDetector(
          onTap: () => _setAgreedToTOS(!_agreedToTOS),
          child: Row(
            children: <Widget>[
              Checkbox(value: _agreedToTOS, onChanged: _setAgreedToTOS),
              Flexible(
                  child: const Text(
                'I agree to the Terms of Service and Privacy Policy',
                style: TextStyle(fontSize: 12),
              ))
            ],
          )),
    );
  }

  submit() {
    if (!_agreedWithTerms()) {
      Toast.show('You must accept the TOS!', context);
      return;
    }

    if (_formKey.currentState.validate() && _agreedWithTerms()) {
      Toast.show('Processing Data', context);
      final name = nameController.text.trim();
      final email = emailController.text.trim();
      final testPassword = passwordController.text.trim();
      Logger().i("""
Name: $name,
Email: $email,
Test Password: $testPassword,
Interests: $interests,
Programming Languages: $programmingLanguages
Skills: $skills""");
    }
  }

  Widget buildSubmitButton() {
    final width = MediaQuery.of(context).size.width * 0.5;
    final height = MediaQuery.of(context).size.width * 0.15;

    return Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Center(
            child: ButtonTheme(
                minWidth: width,
                height: height,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(height * 0.25)),
                  textColor: Theme.of(context).canvasColor,
                  onPressed: () {
                    submit();
                  },
                  child: Text(
                    'Sign Up',
                    style: Theme.of(context)
                        .textTheme
                        .button
                        .apply(fontSizeDelta: -5),
                  ),
                ))));
  }

  bool _agreedWithTerms() {
    return _agreedToTOS;
  }

  void _setAgreedToTOS(bool value) {
    setState(() {
      _agreedToTOS = value;
    });
  }
}
