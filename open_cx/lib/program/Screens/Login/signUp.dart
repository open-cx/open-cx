import 'package:flutter/material.dart';

import 'package:open_cx/Components/SnackBar.dart';
import '../../Model/User.dart';
import 'package:open_cx/Services/auth.dart';

import 'login.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _isHidden = true;

  final AuthService _auth = AuthService();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController signupEmailController = new TextEditingController();
  TextEditingController signupNameController = new TextEditingController();
  TextEditingController signupPasswordController = new TextEditingController();

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFF283468),
      resizeToAvoidBottomPadding: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/porto.png"),
            fit: BoxFit.cover,
          ),
        ),
        padding:
            EdgeInsets.only(top: 100.0, right: 25.0, left: 25.0, bottom: 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 50.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            buildTextField("Email", signupEmailController),
            SizedBox(
              height: 20.0,
            ),
            buildTextField("Username", signupNameController),
            SizedBox(
              height: 20.0,
            ),
            buildTextField("Password", signupPasswordController),
            SizedBox(
              height: 30.0,
            ),
            SizedBox(height: 20.0),
            buildButtonContainer(),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String hintText, TextEditingController controller) {
    var icon;
    switch (hintText) {
      case "Username":
        icon = Icon(Icons.account_circle);
        break;
      case "Email":
        icon = Icon(Icons.email);
        break;
      case "Password":
        icon = Icon(Icons.lock);
        break;
      default:
    }
    return TextField(
      controller: controller,
      style: new TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
        // border: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(20.0),
        // ),
        prefixIcon: icon,
        suffixIcon: hintText == "Password"
            ? IconButton(
                onPressed: _toggleVisibility,
                icon: _isHidden
                    ? Icon(Icons.visibility_off)
                    : Icon(Icons.visibility),
              )
            : null,
      ),
      obscureText: hintText == "Password" ? _isHidden : false,
    );
  }

  Widget buildButtonContainer() {
    return GestureDetector(
      onTap: () {
        print("Name: " + signupNameController.text);
        print("Email: " + signupEmailController.text);
        print("Pass: " + signupPasswordController.text);

        _signUp();
      },
      child: Container(
        height: 56.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
        ),
        child: Center(
          child: Text(
            "Create account",
            style: TextStyle(
              color: Color(0xFF283468),
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  bool _validSignUpInput() {

    if(signupEmailController.text.isEmpty) {
      showInSnackBar(_scaffoldKey, 'Provide an email');
      return false;
    } else if(signupNameController.text.isEmpty) {
      showInSnackBar(_scaffoldKey, 'Provide a name');
      return false;
    } else if(signupPasswordController.text.isEmpty) {
      showInSnackBar(_scaffoldKey, 'Provide a password');
      return false;
    }
    return true;
  }

  void _signUp() async {
    if(_validSignUpInput()) {
//      setState(() => loading = true);
      User user = await _auth.registerWithEmailAndPassword(signupEmailController.text, signupPasswordController.text, signupNameController.text);
      if (user == null) {
//        setState(() => loading = false);
        showInSnackBar(_scaffoldKey, 'Please supply valid credentials');
      } else {
        Navigator.of(context)
            .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
          return new LoginPage();
        }));
      }
    }
  }
}
