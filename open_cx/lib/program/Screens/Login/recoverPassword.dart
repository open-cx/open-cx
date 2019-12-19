import 'package:flutter/material.dart';

import 'login.dart';

class RecoverPasswordPage extends StatefulWidget {
  @override
  _RecoverPasswordState createState() => _RecoverPasswordState();
}

class _RecoverPasswordState extends State<RecoverPasswordPage> {
  bool _isHidden = true;

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              'Recover your Password',
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 60.0,
            ),
            buildTextField("Email"),
            SizedBox(
              height: 20.0,
            ),
            buildTextField("Username"),
            SizedBox(
              height: 20.0,
            ),
            buildTextField("Password"),
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

  Widget buildTextField(String hintText) {
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
        Navigator.of(context)
            .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
          return new LoginPage();
        }));
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
            "Continue",
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
}
