import 'package:flutter/material.dart';
import 'QuestionsPage.dart';
import 'dart:async';

class SessionScreen extends StatelessWidget {
  SessionScreen();
  @override
  Widget build(BuildContext context) { // Initial page seen by the user
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            Container(
              child: Text(
                'Conference\nManager',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 100,
                    fontFamily: 'CustomFont'),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              child: InputSection(), // This is where the user inputs the session code
            ),
          ],
        ),
        backgroundColor: Colors.white,
    );
  }
}

class InputSection extends StatefulWidget{
  InputSection();
  @override
  InputState createState() => new InputState();
}

class InputState extends State<InputSection>{

  final TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: Row( // A row with both the text field and submit button
        children: <Widget>[
          Flexible(  // Here is the text field where the user inputs the session code
            child: TextField(
              style: TextStyle(
                      fontSize: 50),
              controller: controller,
              keyboardType: TextInputType.visiblePassword,
              obscureText: false,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 10),
                  hintText: 'Session Code',
                  hintStyle: TextStyle(
                      fontFamily: 'CustomFont',
                      fontSize: 50,
                      fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(
                      borderRadius:
                      const BorderRadius.all(Radius.circular(0.1))))),
          ),
          Padding(
              padding: EdgeInsets.only(right: 10)
          ),
          SizedBox(  // The submit button, which takes the user to the questions page relative to that code
              width: 200,
              height: 80,
              child: RaisedButton(
                  onPressed: () { // Once the button is pressed, this function is called
                    if (controller.text != "") { // Checking if the input is empty
                      final QuestionsPage questionsPage = new QuestionsPage();
                      questionsPage.setSessionNumber(controller.text);
                      questionsPage.setActive();
                      Timer.periodic(Duration(seconds: 20), (timer) { // Setting up a timer for the questions to be refreshed
                        if (questionsPage.getActive())
                          questionsPage.updateQuestions();
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => questionsPage), // Redirects the user to the questions page
                      );
                    }
                  },
                  child: Text(
                    'Go',
                    style: TextStyle(
                      fontFamily: 'CustomFont',
                      fontSize: 50,
                      fontWeight: FontWeight.bold),
                  ))),
        ],
      ),
    );
  }
}

