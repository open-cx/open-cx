import 'package:flutter/material.dart';

import 'package:open_cx/Components/SnackBar.dart';
import 'package:open_cx/Model/User.dart';
import 'package:open_cx/Services/auth.dart';
import '../MenuOpen.dart';
import 'signUp.dart';
import 'recoverPassword.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _isHidden = true;

  final AuthService _auth = AuthService();

  TextEditingController loginEmailController = new TextEditingController();
  TextEditingController loginPasswordController = new TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
        padding: EdgeInsets.only(
            top: 100.0, right: 25.0, left: 25.0, bottom: 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Agendapp',
              style: TextStyle(
                fontSize: 50.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "‹Programming› 2020",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 60.0,
            ),
            buildTextField("Email", loginEmailController),
            SizedBox(
              height: 20.0,
            ),
            buildTextField("Password", loginPasswordController),
            SizedBox(
              height: 20.0,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              RecoverPasswordPage()
                      ));
                    },
                    child: Text(
                      "Forgot your Password?",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20.0),
            buildButtonContainer(),
            SizedBox(
              height: 10.0,
            ),
            Container(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Don't have an account?",
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    SizedBox(
                      width: 10.0,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute<Null>(
                              builder: (BuildContext context) {
                                return new SignUpPage();
                              }));
                        },
                        child: Text("SIGN UP",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            )))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String hintText, TextEditingController controller) {
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
        prefixIcon: hintText == "Email"
            ? Icon(Icons.email)
            : Icon(Icons.lock),
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
        print("Pass: " + loginPasswordController.text);
        print("Email: " + loginEmailController.text);
        _signIn();
      },
      child: Container(
        height: 56.0,
        width: MediaQuery
            .of(context)
            .size
            .width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
        ),
        child: Center(
          child: Text(
            "Login",
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

  bool _validSignInInput() {
    if (loginEmailController.text.isEmpty) {
      showInSnackBar(_scaffoldKey, 'Provide an email');
      return false;
    } else if (loginPasswordController.text.isEmpty) {
      showInSnackBar(_scaffoldKey, 'Provide a password');
      return false;
    }
    return true;
  }

  void _signIn() async {
    if (_validSignInInput()) {
//      setState(() => loading = true);
      User user = await _auth.signInWithEmailAndPassword(
          loginEmailController.text, loginPasswordController.text);
      if (user == null) {
//        setState(() => loading = false);
        showInSnackBar(
            _scaffoldKey, 'Could not sign in with those credentials');
      } else {
        Navigator.of(context)
            .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
          return new MenuPage();
        }));
      }
    }
  }

}
