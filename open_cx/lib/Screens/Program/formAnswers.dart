import 'formQuestions.dart';
import '../MenuOpen.dart';
import 'package:flutter/material.dart';

class FormAnswers extends StatefulWidget {
  final List<String> answers;

  FormAnswers({Key key, this.answers}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return Answers();
  }
}

class Answers extends State<FormAnswers> {
  Widget getAnswer(String number) {
    String text;

    switch (number) {
      case "-1":
        text = "NOT ANSWERED";
        break;
      case "0":
        text = "Strongly disagree";
        break;
      case "1":
        text = "Disagree";
        break;
      case "2":
        text = "Don't know";
        break;
      case "3":
        text = "Agree";
        break;
      case "4":
        text = "Strongly agree";
        break;
      default:
        if(number[0]=='[') {
          text = number.substring(1,number.length-1);
        }
        else {
          text = number;
        }
        break;
    }

    return Text(text);
  }

  Widget getListView() {
    var listItems = widget.answers;

    var listView = ListView.builder(
        itemCount: listItems.sublist(0,10).length,
        itemBuilder: (context, index) {
          return ListTile(
              leading: Icon(Icons.keyboard_arrow_right),
              title: Text("Question ${index + 1}"),
              subtitle: getAnswer(listItems[index]),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  switch (index) {
                    case 0:
                      return FirstQuestion(answers: widget.answers);
                    case 1:
                      return SecondQuestion(answers: widget.answers);
                    case 2:
                      return ThirdQuestion(answers: widget.answers);
                    case 3:
                      return FourthQuestion(answers: widget.answers);
                    case 4:
                      return FifthQuestion(answers: widget.answers);
                    case 5:
                      return SixthQuestion(answers: widget.answers);
                    case 6:
                      return SeventhQuestion(answers: widget.answers);
                    case 7:
                      return EighthQuestion(answers: widget.answers);
                    case 8:
                      return NinethQuestion(answers: widget.answers);
                    case 9:
                      return TenthQuestion(answers: widget.answers);
                    default:
                      return FormAnswers(answers: widget.answers);
                  }
                }));
              });
        });
    return listView;
  }

  GlobalKey<ScaffoldState> scaffoldState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldState,
        backgroundColor: Colors.white,
        appBar: AppBar(
            title: Text('CORE'),
            backgroundColor: new Color(0xFF002A72),
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return MenuPage();
                  }));
                })),
        body: Builder(
          builder: (context) => Container(
              child: Padding(
                padding: EdgeInsets.only(top: 30, left: 20, right: 20),
                child: getListView(),
              )),
        ),
        bottomNavigationBar: Builder(
            builder: (context) =>Container(
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return MenuPage();
                        }));
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: new Color(0xFF002A72)),
                      ),
                      color: Colors.white,
                    ),
                    _build(context),
                  ],
                ),),
            )));
  }

  Widget _build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        bool missing_answer = false;
        for (int i = 0; i < widget.answers.length; i++) {
          if (widget.answers[i] == "-1") {
            missing_answer = true;
            break;
          }
        }
        if (missing_answer == false) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) {
                debugPrint(widget.answers.toString());
                return MenuPage();
              }));
        } else {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("Please answer all questions"),
          ));
        }
      },
      child: Text("Submit", style: TextStyle(color: Colors.white)),
      color: new Color(0xFF002A72),
    );}
}