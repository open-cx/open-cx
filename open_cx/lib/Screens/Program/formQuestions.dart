import 'formAnswers.dart';
import '../MenuOpen.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class FirstQuestion extends StatefulWidget {
  List<String> answers;

  FirstQuestion({Key key, this.answers}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return Question1();
  }
}

class Question1 extends State<FirstQuestion> {
  List<String> q1_checked;
  int _radioValue = -1;

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('CORE'),
        backgroundColor: new Color(0xFF002A72),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.close),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MenuPage();
              }))
          ),
        ],
      ),
      body: Container(
          child: Column(children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 40, right: 40, top: 30),
              child: LinearPercentIndicator(
                animation: true,
                lineHeight: 15.0,
                animationDuration: 0,
                percent: 0.10,
                linearStrokeCap: LinearStrokeCap.roundAll,
                progressColor: Colors.greenAccent,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 40, right: 40, top: 30, bottom: 20),
              child: Text(
                "You believe the best solutions come from a safe environment where teammates can share ideas",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 40),
                child: Column(children: <Widget>[
                  Row(children: <Widget>[
                    Radio(
                      value: 0,
                      groupValue: _radioValue,
                      onChanged: _handleRadioValueChange,
                    ),
                    Text("Strongly disagree"),
                  ]),
                  Row(children: <Widget>[
                    Radio(
                      value: 1,
                      groupValue: _radioValue,
                      onChanged: _handleRadioValueChange,
                    ),
                    Text("Disagree"),
                  ]),
                  Row(children: <Widget>[
                    Radio(
                      value: 2,
                      groupValue: _radioValue,
                      onChanged: _handleRadioValueChange,
                    ),
                    Text("Don't know"),
                  ]),
                  Row(children: <Widget>[
                    Radio(
                      value: 3,
                      groupValue: _radioValue,
                      onChanged: _handleRadioValueChange,
                    ),
                    Text("Agree"),
                  ]),
                  Row(children: <Widget>[
                    Radio(
                      value: 4,
                      groupValue: _radioValue,
                      onChanged: _handleRadioValueChange,
                    ),
                    Text("Strongly agree"),
                  ]),
                ]))
          ])),
      bottomNavigationBar: Container(
          child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: getButtons(),
          )),
    );
  }

  Widget getButtons() {
    if (widget.answers == null || widget.answers.length == 1) {
      return ButtonBar(
        alignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MenuPage();
              }));
            },
            child: Text(
              "Back",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: new Color(0xFF002A72)),
            ),
            color: Colors.white,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                if (widget.answers != null) {
                  widget.answers[0] = "$_radioValue";
                  debugPrint(widget.answers.toString());
                  return SecondQuestion(answers: widget.answers);
                } else {
                  List<String> ans;
                  ans = ["$_radioValue"];
                  //debugPrint(ans.toString());
                  return SecondQuestion(answers: ans);
                }
              }));
            },
            child: Text("Next", style: TextStyle(color: Colors.white)),
            color: new Color(0xFF002A72),
          )
        ],
      );
    } else {
      return ButtonBar(
        alignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return FormAnswers(answers: widget.answers);
              }));
            },
            child: Text(
              "Cancel",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: new Color(0xFF002A72)),
            ),
            color: Colors.white,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                if (widget.answers != null) {
                  widget.answers[0] = "$_radioValue";
                  debugPrint(widget.answers.toString());
                  return FormAnswers(answers: widget.answers);
                } else {
                  List<String> ans;
                  ans = ["$_radioValue"];
                  //debugPrint(ans.toString());
                  return FormAnswers(answers: ans);
                }
              }));
            },
            child: Text("Resubmit", style: TextStyle(color: Colors.white)),
            color: new Color(0xFF002A72),
          )
        ],
      );
    }
  }
}

class SecondQuestion extends StatefulWidget {
  List<String> answers;
  bool answered;

  SecondQuestion({Key key, this.answers}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return Question2();
  }
}

class Question2 extends State<SecondQuestion> {
  List<String> q2_checked;

  List<String> checked;
  int _radioValue = -1;

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('CORE'),
        backgroundColor: new Color(0xFF002A72),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.close),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MenuPage();
              }))
          ),
        ],
      ),
      body: Container(
          child: Column(children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 40, right: 40, top: 30),
              child: LinearPercentIndicator(
                animation: true,
                lineHeight: 15.0,
                animationDuration: 0,
                percent: 0.10 * 2,
                linearStrokeCap: LinearStrokeCap.roundAll,
                progressColor: Colors.greenAccent,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 40, right: 40, top: 30, bottom: 20),
              child: Text(
                "You're always looking for which Javascript framework offers you the best performance",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 40),
                child: Column(children: <Widget>[
                  Row(children: <Widget>[
                    Radio(
                      value: 0,
                      groupValue: _radioValue,
                      onChanged: _handleRadioValueChange,
                    ),
                    Text("Strongly disagree"),
                  ]),
                  Row(children: <Widget>[
                    Radio(
                      value: 1,
                      groupValue: _radioValue,
                      onChanged: _handleRadioValueChange,
                    ),
                    Text("Disagree"),
                  ]),
                  Row(children: <Widget>[
                    Radio(
                      value: 2,
                      groupValue: _radioValue,
                      onChanged: _handleRadioValueChange,
                    ),
                    Text("Don't know"),
                  ]),
                  Row(children: <Widget>[
                    Radio(
                      value: 3,
                      groupValue: _radioValue,
                      onChanged: _handleRadioValueChange,
                    ),
                    Text("Agree"),
                  ]),
                  Row(children: <Widget>[
                    Radio(
                      value: 4,
                      groupValue: _radioValue,
                      onChanged: _handleRadioValueChange,
                    ),
                    Text("Strongly agree"),
                  ]),
                ]))
          ])),
      bottomNavigationBar: Container(
          child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: getButtons(),
          )),
    );
  }

  Widget getButtons() {
    if (widget.answers.length == 1) {
      return ButtonBar(
        alignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return FirstQuestion(
                  answers: widget.answers,
                );
              }));
            },
            child: Text(
              "Back",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: new Color(0xFF002A72)),
            ),
            color: Colors.white,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                widget.answers.add("$_radioValue");
                return ThirdQuestion(answers: widget.answers);
              }));
            },
            child: Text("Next", style: TextStyle(color: Colors.white)),
            color: new Color(0xFF002A72),
          )
        ],
      );
    } else if (widget.answers.length == 2) {
      return ButtonBar(
        alignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return FirstQuestion(
                  answers: widget.answers,
                );
              }));
            },
            child: Text(
              "Back",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: new Color(0xFF002A72)),
            ),
            color: Colors.white,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                widget.answers[1] = "$_radioValue";
                return ThirdQuestion(answers: widget.answers);
              }));
            },
            child: Text("Next", style: TextStyle(color: Colors.white)),
            color: new Color(0xFF002A72),
          )
        ],
      );
    } else {
      return ButtonBar(
        alignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return FormAnswers(answers: widget.answers);
              }));
            },
            child: Text(
              "Cancel",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: new Color(0xFF002A72)),
            ),
            color: Colors.white,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                widget.answers[1] = "$_radioValue";
                return FormAnswers(answers: widget.answers);
              }));
            },
            child: Text("Resubmit", style: TextStyle(color: Colors.white)),
            color: new Color(0xFF002A72),
          )
        ],
      );
    }
  }
}

class ThirdQuestion extends StatefulWidget {
  List<String> answers;
  bool answered;

  ThirdQuestion({Key key, this.answers}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return Question3();
  }
}

class Question3 extends State<ThirdQuestion> {
  List<String> checked;
  int _radioValue = -1;

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('CORE'),
        backgroundColor: new Color(0xFF002A72),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.close),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MenuPage();
              }))
          ),
        ],
      ),
      body: Container(
          child: Column(children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 40, right: 40, top: 30),
              child: LinearPercentIndicator(
                animation: true,
                lineHeight: 15.0,
                animationDuration: 0,
                percent: 0.10 * 3,
                linearStrokeCap: LinearStrokeCap.roundAll,
                progressColor: Colors.greenAccent,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 40, right: 40, top: 30, bottom: 20),
              child: Text(
                "You protect your info, shop safely, clean up your cache and change passwords frequently",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 40),
                child: Column(children: <Widget>[
                  Row(children: <Widget>[
                    Radio(
                      value: 0,
                      groupValue: _radioValue,
                      onChanged: _handleRadioValueChange,
                    ),
                    Text("Strongly disagree"),
                  ]),
                  Row(children: <Widget>[
                    Radio(
                      value: 1,
                      groupValue: _radioValue,
                      onChanged: _handleRadioValueChange,
                    ),
                    Text("Disagree"),
                  ]),
                  Row(children: <Widget>[
                    Radio(
                      value: 2,
                      groupValue: _radioValue,
                      onChanged: _handleRadioValueChange,
                    ),
                    Text("Don't know"),
                  ]),
                  Row(children: <Widget>[
                    Radio(
                      value: 3,
                      groupValue: _radioValue,
                      onChanged: _handleRadioValueChange,
                    ),
                    Text("Agree"),
                  ]),
                  Row(children: <Widget>[
                    Radio(
                      value: 4,
                      groupValue: _radioValue,
                      onChanged: _handleRadioValueChange,
                    ),
                    Text("Strongly agree"),
                  ]),
                ]))
          ])),
      bottomNavigationBar: Container(
          child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: getButtons(),
          )),
    );
  }

  Widget getButtons() {
    if (widget.answers.length == 2) {
      return ButtonBar(
        alignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SecondQuestion(
                  answers: widget.answers,
                );
              }));
            },
            child: Text(
              "Back",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: new Color(0xFF002A72)),
            ),
            color: Colors.white,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                widget.answers.add("$_radioValue");
                return FourthQuestion(answers: widget.answers);
              }));
            },
            child: Text("Next", style: TextStyle(color: Colors.white)),
            color: new Color(0xFF002A72),
          )
        ],
      );
    } else if (widget.answers.length == 3) {
      return ButtonBar(
        alignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SecondQuestion(
                  answers: widget.answers,
                );
              }));
            },
            child: Text(
              "Back",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: new Color(0xFF002A72)),
            ),
            color: Colors.white,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                widget.answers[2] = "$_radioValue";
                return FourthQuestion(answers: widget.answers);
              }));
            },
            child: Text("Next", style: TextStyle(color: Colors.white)),
            color: new Color(0xFF002A72),
          )
        ],
      );
    } else {
      return ButtonBar(
        alignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return FormAnswers(answers: widget.answers);
              }));
            },
            child: Text(
              "Cancel",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: new Color(0xFF002A72)),
            ),
            color: Colors.white,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                widget.answers[2] = "$_radioValue";
                return FormAnswers(answers: widget.answers);
              }));
            },
            child: Text("Resubmit", style: TextStyle(color: Colors.white)),
            color: new Color(0xFF002A72),
          )
        ],
      );
    }
  }
}

class FourthQuestion extends StatefulWidget {
  List<String> answers;
  bool answered;

  FourthQuestion({Key key, this.answers}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return Question4();
  }
}

class Question4 extends State<FourthQuestion> {
  List<String> checked;
  int _radioValue = -1;

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('CORE'),
        backgroundColor: new Color(0xFF002A72),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.close),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MenuPage();
              }))
          ),
        ],
      ),
      body: Container(
          child: Column(children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 40, right: 40, top: 30),
              child: LinearPercentIndicator(
                animation: true,
                lineHeight: 15.0,
                animationDuration: 0,
                percent: 0.10 * 4,
                linearStrokeCap: LinearStrokeCap.roundAll,
                progressColor: Colors.greenAccent,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 20),
              child: Text(
                "You believe AI is a wonder of modern science that has made a lot of things possible that were unthinkable before",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 40),
                child: Column(children: <Widget>[
                  Row(children: <Widget>[
                    Radio(
                      value: 0,
                      groupValue: _radioValue,
                      onChanged: _handleRadioValueChange,
                    ),
                    Text("Strongly disagree"),
                  ]),
                  Row(children: <Widget>[
                    Radio(
                      value: 1,
                      groupValue: _radioValue,
                      onChanged: _handleRadioValueChange,
                    ),
                    Text("Disagree"),
                  ]),
                  Row(children: <Widget>[
                    Radio(
                      value: 2,
                      groupValue: _radioValue,
                      onChanged: _handleRadioValueChange,
                    ),
                    Text("Don't know"),
                  ]),
                  Row(children: <Widget>[
                    Radio(
                      value: 3,
                      groupValue: _radioValue,
                      onChanged: _handleRadioValueChange,
                    ),
                    Text("Agree"),
                  ]),
                  Row(children: <Widget>[
                    Radio(
                      value: 4,
                      groupValue: _radioValue,
                      onChanged: _handleRadioValueChange,
                    ),
                    Text("Strongly agree"),
                  ]),
                ]))
          ])),
      bottomNavigationBar: Container(
          child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: getButtons(),
          )),
    );
  }

  Widget getButtons() {
    if (widget.answers.length == 3) {
      return ButtonBar(
        alignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ThirdQuestion(
                  answers: widget.answers,
                );
              }));
            },
            child: Text(
              "Back",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: new Color(0xFF002A72)),
            ),
            color: Colors.white,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                widget.answers.add("$_radioValue");
                return FifthQuestion(answers: widget.answers);
              }));
            },
            child: Text("Next", style: TextStyle(color: Colors.white)),
            color: new Color(0xFF002A72),
          )
        ],
      );
    } else if (widget.answers.length == 4) {
      return ButtonBar(
        alignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ThirdQuestion(
                  answers: widget.answers,
                );
              }));
            },
            child: Text(
              "Back",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: new Color(0xFF002A72)),
            ),
            color: Colors.white,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                widget.answers[3] = "$_radioValue";
                return FifthQuestion(answers: widget.answers);
              }));
            },
            child: Text("Next", style: TextStyle(color: Colors.white)),
            color: new Color(0xFF002A72),
          )
        ],
      );
    } else {
      return ButtonBar(
        alignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return FormAnswers(answers: widget.answers);
              }));
            },
            child: Text(
              "Cancel",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: new Color(0xFF002A72)),
            ),
            color: Colors.white,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                widget.answers[3] = "$_radioValue";
                return FormAnswers(answers: widget.answers);
              }));
            },
            child: Text("Resubmit", style: TextStyle(color: Colors.white)),
            color: new Color(0xFF002A72),
          )
        ],
      );
    }
  }
}

class FifthQuestion extends StatefulWidget {
  List<String> answers;
  bool answered;

  FifthQuestion({Key key, this.answers}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return Question5();
  }
}

class Question5 extends State<FifthQuestion> {
  List<String> checked;
  int _radioValue = -1;

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('CORE'),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.close),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MenuPage();
              }))
          ),
        ],
      ),
      body: Container(
          child: Column(children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 40, right: 40, top: 30),
              child: LinearPercentIndicator(
                animation: true,
                lineHeight: 15.0,
                animationDuration: 0,
                percent: 0.10 * 5,
                linearStrokeCap: LinearStrokeCap.roundAll,
                progressColor: Colors.greenAccent,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 20),
              child: Text(
                "Your biggest wish is to have a smart home where IoT devices provide lighting, heating, media and security systems",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 40),
                child: Column(children: <Widget>[
                  Row(children: <Widget>[
                    Radio(
                      value: 0,
                      groupValue: _radioValue,
                      onChanged: _handleRadioValueChange,
                    ),
                    Text("Strongly disagree"),
                  ]),
                  Row(children: <Widget>[
                    Radio(
                      value: 1,
                      groupValue: _radioValue,
                      onChanged: _handleRadioValueChange,
                    ),
                    Text("Disagree"),
                  ]),
                  Row(children: <Widget>[
                    Radio(
                      value: 2,
                      groupValue: _radioValue,
                      onChanged: _handleRadioValueChange,
                    ),
                    Text("Don't know"),
                  ]),
                  Row(children: <Widget>[
                    Radio(
                      value: 3,
                      groupValue: _radioValue,
                      onChanged: _handleRadioValueChange,
                    ),
                    Text("Agree"),
                  ]),
                  Row(children: <Widget>[
                    Radio(
                      value: 4,
                      groupValue: _radioValue,
                      onChanged: _handleRadioValueChange,
                    ),
                    Text("Strongly agree"),
                  ]),
                ]))
          ])),
      bottomNavigationBar: Container(
          child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: getButtons(),
          )),
    );
  }

  Widget getButtons() {
    if (widget.answers.length == 4) {
      return ButtonBar(
        alignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return FourthQuestion(
                  answers: widget.answers,
                );
              }));
            },
            child: Text(
              "Back",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: new Color(0xFF002A72)),
            ),
            color: Colors.white,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                widget.answers.add("$_radioValue");
                return SixthQuestion(answers: widget.answers);
              }));
            },
            child: Text("Next", style: TextStyle(color: Colors.white)),
            color: new Color(0xFF002A72),
          )
        ],
      );
    } else if (widget.answers.length == 5) {
      return ButtonBar(
        alignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return FourthQuestion(
                  answers: widget.answers,
                );
              }));
            },
            child: Text(
              "Back",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: new Color(0xFF002A72)),
            ),
            color: Colors.white,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                widget.answers[4] = "$_radioValue";
                return SixthQuestion(answers: widget.answers);
              }));
            },
            child: Text("Next", style: TextStyle(color: Colors.white)),
            color: new Color(0xFF002A72),
          )
        ],
      );
    } else {
      return ButtonBar(
        alignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return FormAnswers(answers: widget.answers);
              }));
            },
            child: Text(
              "Cancel",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: new Color(0xFF002A72)),
            ),
            color: Colors.white,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                widget.answers[4] = "$_radioValue";
                return FormAnswers(answers: widget.answers);
              }));
            },
            child: Text("Resubmit", style: TextStyle(color: Colors.white)),
            color: new Color(0xFF002A72),
          )
        ],
      );
    }
  }
}

class SixthQuestion extends StatefulWidget {
  List<String> answers;
  bool answered;

  SixthQuestion({Key key, this.answers}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return Question6();
  }
}

class Question6 extends State<SixthQuestion> {
  List<String> checked;
  int _radioValue = -1;

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('CORE'),
        backgroundColor: new Color(0xFF002A72),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.close),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MenuPage();
              }))
          ),
        ],
      ),
      body: Container(
          child: Column(children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 40, right: 40, top: 30),
              child: LinearPercentIndicator(
                animation: true,
                lineHeight: 15.0,
                animationDuration: 0,
                percent: 0.10 * 6,
                linearStrokeCap: LinearStrokeCap.roundAll,
                progressColor: Colors.greenAccent,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 40, right: 40, top: 30, bottom: 20),
              child: Text(
                "You know how important it is to provide a positive user experience",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 40),
                child: Column(children: <Widget>[
                  Row(children: <Widget>[
                    Radio(
                      value: 0,
                      groupValue: _radioValue,
                      onChanged: _handleRadioValueChange,
                    ),
                    Text("Strongly disagree"),
                  ]),
                  Row(children: <Widget>[
                    Radio(
                      value: 1,
                      groupValue: _radioValue,
                      onChanged: _handleRadioValueChange,
                    ),
                    Text("Disagree"),
                  ]),
                  Row(children: <Widget>[
                    Radio(
                      value: 2,
                      groupValue: _radioValue,
                      onChanged: _handleRadioValueChange,
                    ),
                    Text("Don't know"),
                  ]),
                  Row(children: <Widget>[
                    Radio(
                      value: 3,
                      groupValue: _radioValue,
                      onChanged: _handleRadioValueChange,
                    ),
                    Text("Agree"),
                  ]),
                  Row(children: <Widget>[
                    Radio(
                      value: 4,
                      groupValue: _radioValue,
                      onChanged: _handleRadioValueChange,
                    ),
                    Text("Strongly agree"),
                  ]),
                ]))
          ])),
      bottomNavigationBar: Container(
          child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: getButtons(),
          )),
    );
  }

  Widget getButtons() {
    if (widget.answers.length == 5) {
      return ButtonBar(
        alignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return FifthQuestion(
                  answers: widget.answers,
                );
              }));
            },
            child: Text(
              "Back",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: new Color(0xFF002A72)),
            ),
            color: Colors.white,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                widget.answers.add("$_radioValue");
                return SeventhQuestion(answers: widget.answers);
              }));
            },
            child: Text("Next", style: TextStyle(color: Colors.white)),
            color: new Color(0xFF002A72),
          )
        ],
      );
    } else if (widget.answers.length == 6) {
      return ButtonBar(
        alignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return FifthQuestion(
                  answers: widget.answers,
                );
              }));
            },
            child: Text(
              "Back",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: new Color(0xFF002A72)),
            ),
            color: Colors.white,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                widget.answers[5] = "$_radioValue";
                return SeventhQuestion(answers: widget.answers);
              }));
            },
            child: Text("Next", style: TextStyle(color: Colors.white)),
            color: new Color(0xFF002A72),
          )
        ],
      );
    } else {
      return ButtonBar(
        alignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return FormAnswers(answers: widget.answers);
              }));
            },
            child: Text(
              "Cancel",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: new Color(0xFF002A72)),
            ),
            color: Colors.white,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                widget.answers[5] = "$_radioValue";
                return FormAnswers(answers: widget.answers);
              }));
            },
            child: Text("Resubmit", style: TextStyle(color: Colors.white)),
            color: new Color(0xFF002A72),
          )
        ],
      );
    }
  }
}

class SeventhQuestion extends StatefulWidget {
  List<String> answers;
  bool answered;

  SeventhQuestion({Key key, this.answers}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return Question7();
  }
}

class Question7 extends State<SeventhQuestion> {
  List<String> checked;
  int _radioValue = -1;

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('CORE'),
        backgroundColor: new Color(0xFF002A72),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.close),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MenuPage();
              }))
          ),
        ],
      ),
      body: Container(
          child: Column(children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 40, right: 40, top: 30),
              child: LinearPercentIndicator(
                animation: true,
                lineHeight: 15.0,
                animationDuration: 0,
                percent: 0.10 * 7,
                linearStrokeCap: LinearStrokeCap.roundAll,
                progressColor: Colors.greenAccent,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 40, right: 40, top: 30, bottom: 20),
              child: Text(
                "You believe decentralized cryptocurrencies will see increased use from all sectors",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 40),
                child: Column(children: <Widget>[
                  Row(children: <Widget>[
                    Radio(
                      value: 0,
                      groupValue: _radioValue,
                      onChanged: _handleRadioValueChange,
                    ),
                    Text("Strongly disagree"),
                  ]),
                  Row(children: <Widget>[
                    Radio(
                      value: 1,
                      groupValue: _radioValue,
                      onChanged: _handleRadioValueChange,
                    ),
                    Text("Disagree"),
                  ]),
                  Row(children: <Widget>[
                    Radio(
                      value: 2,
                      groupValue: _radioValue,
                      onChanged: _handleRadioValueChange,
                    ),
                    Text("Don't know"),
                  ]),
                  Row(children: <Widget>[
                    Radio(
                      value: 3,
                      groupValue: _radioValue,
                      onChanged: _handleRadioValueChange,
                    ),
                    Text("Agree"),
                  ]),
                  Row(children: <Widget>[
                    Radio(
                      value: 4,
                      groupValue: _radioValue,
                      onChanged: _handleRadioValueChange,
                    ),
                    Text("Strongly agree"),
                  ]),
                ]))
          ])),
      bottomNavigationBar: Container(
          child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: getButtons(),
          )),
    );
  }

  Widget getButtons() {
    if (widget.answers.length == 6) {
      return ButtonBar(
        alignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SixthQuestion(
                  answers: widget.answers,
                );
              }));
            },
            child: Text(
              "Back",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: new Color(0xFF002A72)),
            ),
            color: Colors.white,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                widget.answers.add("$_radioValue");
                return EighthQuestion(answers: widget.answers);
              }));
            },
            child: Text("Next", style: TextStyle(color: Colors.white)),
            color: new Color(0xFF002A72),
          )
        ],
      );
    } else if (widget.answers.length == 7) {
      return ButtonBar(
        alignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SixthQuestion(
                  answers: widget.answers,
                );
              }));
            },
            child: Text(
              "Back",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: new Color(0xFF002A72)),
            ),
            color: Colors.white,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                widget.answers[6] = "$_radioValue";
                return EighthQuestion(answers: widget.answers);
              }));
            },
            child: Text("Next", style: TextStyle(color: Colors.white)),
            color: new Color(0xFF002A72),
          )
        ],
      );
    } else {
      return ButtonBar(
        alignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return FormAnswers(answers: widget.answers);
              }));
            },
            child: Text(
              "Cancel",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: new Color(0xFF002A72)),
            ),
            color: Colors.white,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                widget.answers[6] = "$_radioValue";
                return FormAnswers(answers: widget.answers);
              }));
            },
            child: Text("Resubmit", style: TextStyle(color: Colors.white)),
            color: new Color(0xFF002A72),
          )
        ],
      );
    }
  }
}

class EighthQuestion extends StatefulWidget {
  List<String> answers;
  bool answered;

  EighthQuestion({Key key, this.answers}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return Question8();
  }
}

class Question8 extends State<EighthQuestion> {
  List<String> checked;
  int _radioValue = -1;

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('CORE'),
        backgroundColor: new Color(0xFF002A72),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.close),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MenuPage();
              }))
          ),
        ],
      ),
      body: Container(
          child: Column(children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 40, right: 40, top: 30),
              child: LinearPercentIndicator(
                animation: true,
                lineHeight: 15.0,
                animationDuration: 0,
                percent: 0.10 * 8,
                linearStrokeCap: LinearStrokeCap.roundAll,
                progressColor: Colors.greenAccent,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 40, right: 40, top: 30, bottom: 20),
              child: Text(
                "You can't commit to a single operating system environment so virtual machines are a lifesaver",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 40),
                child: Column(children: <Widget>[
                  Row(children: <Widget>[
                    Radio(
                      value: 0,
                      groupValue: _radioValue,
                      onChanged: _handleRadioValueChange,
                    ),
                    Text("Strongly disagree"),
                  ]),
                  Row(children: <Widget>[
                    Radio(
                      value: 1,
                      groupValue: _radioValue,
                      onChanged: _handleRadioValueChange,
                    ),
                    Text("Disagree"),
                  ]),
                  Row(children: <Widget>[
                    Radio(
                      value: 2,
                      groupValue: _radioValue,
                      onChanged: _handleRadioValueChange,
                    ),
                    Text("Don't know"),
                  ]),
                  Row(children: <Widget>[
                    Radio(
                      value: 3,
                      groupValue: _radioValue,
                      onChanged: _handleRadioValueChange,
                    ),
                    Text("Agree"),
                  ]),
                  Row(children: <Widget>[
                    Radio(
                      value: 4,
                      groupValue: _radioValue,
                      onChanged: _handleRadioValueChange,
                    ),
                    Text("Strongly agree"),
                  ]),
                ]))
          ])),
      bottomNavigationBar: Container(
          child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: getButtons(),
          )),
    );
  }

  Widget getButtons() {
    if (widget.answers.length == 7) {
      return ButtonBar(
        alignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SeventhQuestion(
                  answers: widget.answers,
                );
              }));
            },
            child: Text(
              "Back",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: new Color(0xFF002A72)),
            ),
            color: Colors.white,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                widget.answers.add("$_radioValue");
                return NinethQuestion(answers: widget.answers);
              }));
            },
            child: Text("Next", style: TextStyle(color: Colors.white)),
            color: new Color(0xFF002A72),
          )
        ],
      );
    } else if (widget.answers.length == 8) {
      return ButtonBar(
        alignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SeventhQuestion(
                  answers: widget.answers,
                );
              }));
            },
            child: Text(
              "Back",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: new Color(0xFF002A72)),
            ),
            color: Colors.white,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                widget.answers[7] = "$_radioValue";
                return NinethQuestion(answers: widget.answers);
              }));
            },
            child: Text("Next", style: TextStyle(color: Colors.white)),
            color: new Color(0xFF002A72),
          )
        ],
      );
    } else {
      return ButtonBar(
        alignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return FormAnswers(answers: widget.answers);
              }));
            },
            child: Text(
              "Cancel",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: new Color(0xFF002A72)),
            ),
            color: Colors.white,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                widget.answers[7] = "$_radioValue";
                return FormAnswers(answers: widget.answers);
              }));
            },
            child: Text("Resubmit", style: TextStyle(color: Colors.white)),
            color: new Color(0xFF002A72),
          )
        ],
      );
    }
  }
}

class NinethQuestion extends StatefulWidget {
  List<String> answers;
  bool answered;

  NinethQuestion({Key key, this.answers}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return Question9();
  }
}

class Question9 extends State<NinethQuestion> {
  List<String> types = [
    'Talk',
    'Tutorial',
    'Research paper',
    'Short-paper',
    'Poster',
  ];

  List<bool> filled = [false, false, false, false, false];

  List<bool> type_droped = [false, false, false, false, false];

  List<String> rank = new List<String>(5);

  void resetButton() {
    setState(() {
      filled = [false, false, false, false, false];
      type_droped = [false, false, false, false, false];
      rank = new List<String>(5);
    });
  }

  Widget getDragItem(int k) {
    if (type_droped[k] == false) {
      return Draggable(
        data: k,
        child: getDraggable(k),
        feedback: getFeedback(k),
        childWhenDragging: getChild(k),
      );
    } else {
      return Container(
        width: 120,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              types[k],
              style: TextStyle(color: Colors.blueGrey[300], fontSize: 14),
            ),
          ),
        ),
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blueGrey[300],
            ),
            borderRadius: BorderRadius.all(Radius.circular(5))),
      );
    }
  }

  Widget getDraggable(int k) {
    if (type_droped[k] == false) {
      return Container(
        width: 120,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              types[k],
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ),
        decoration: BoxDecoration(
            color: Colors.blueGrey[300],
            borderRadius: BorderRadius.all(Radius.circular(5))),
      );
    } else {
      return Container(
        width: 120,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              types[k],
              style: TextStyle(color: Colors.blueGrey[300], fontSize: 14),
            ),
          ),
        ),
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blueGrey[300],
            ),
            borderRadius: BorderRadius.all(Radius.circular(5))),
      );
    }
  }

  Widget getFeedback(int k) {
    return Container(
      width: 120,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            types[k],
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ),
      decoration: BoxDecoration(
          color: Colors.blueGrey[300],
          borderRadius: BorderRadius.all(Radius.circular(5))),
    );
  }

  Widget getChild(int k) {
    return Container(
      width: 120,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            types[k],
            style: TextStyle(color: Colors.blueGrey[300], fontSize: 14),
          ),
        ),
      ),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.blueGrey[300],
          ),
          borderRadius: BorderRadius.all(Radius.circular(5))),
    );
  }

  Widget getDropable(int num) {
    if (filled[num] == false) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Container(
          width: 110,
          decoration: BoxDecoration(
              color: Colors.blueGrey[50],
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: DragTarget(
            builder: (context, List<int> candidateData, rejectedData) {
              print(candidateData);
              return Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 8, bottom: 8, left: 50, right: 50),
                    child: Text(
                      (num + 1).toString(),
                      style: TextStyle(color: Colors.blueGrey[100], fontSize: 15),
                    ),
                  ));
            },
            onAccept: (data) {
              filled[num] = true;
              rank[num] = types[data];
              setState(() {
                type_droped[data] = true;
              });
            },
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Container(
          width: 120,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                rank[num],
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ),
          decoration: BoxDecoration(
              color: Colors.blueGrey[300],
              borderRadius: BorderRadius.all(Radius.circular(5))),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('CORE'),
        backgroundColor: new Color(0xFF002A72),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.close),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MenuPage();
              }))
          ),
        ],
      ),
      body: Container(
          child: Column(children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 40, right: 40, top: 30),
              child: LinearPercentIndicator(
                animation: true,
                lineHeight: 15.0,
                animationDuration: 0,
                percent: 0.10 * 9,
                linearStrokeCap: LinearStrokeCap.roundAll,
                progressColor: Colors.greenAccent,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 40, right: 40, top: 30, bottom: 20),
              child: Text(
                "Sort the following topics according to your preference",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Column(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: getDragItem(0),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: getDragItem(1),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: getDragItem(2)),
                    Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: getDragItem(3)),
                    Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: getDragItem(4)),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: Column(
                    children: <Widget>[
                      getDropable(0),
                      getDropable(1),
                      getDropable(2),
                      getDropable(3),
                      getDropable(4),
                    ],
                  ),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: getResetButton(),
            ),
          ])),
      bottomNavigationBar: Container(
          child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: getButtons(),
          )),
    );
  }

  Widget getResetButton() {
    return ButtonTheme(
      minWidth: 50,
      child: RaisedButton(
        onPressed: () {
          resetButton();
        },
        child: Icon(Icons.restore),
        color: Colors.blueGrey[50],
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(90),
        ),
      ),
    );
  }

  Widget getButtons() {
    if (widget.answers.length == 8) {
      return ButtonBar(
        alignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return EighthQuestion(
                  answers: widget.answers,
                );
              }));
            },
            child: Text(
              "Back",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: new Color(0xFF002A72)),
            ),
            color: Colors.white,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                debugPrint(rank.toString());
                if (rank.contains(null)) {
                  widget.answers.add("-1");
                } else {
                  widget.answers.add(rank.toString());
                }
                return TenthQuestion(answers: widget.answers);
              }));
            },
            child: Text("Next", style: TextStyle(color: Colors.white)),
            color: new Color(0xFF002A72),
          )
        ],
      );
    } else if (widget.answers.length == 9) {
      return ButtonBar(
        alignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return EighthQuestion(
                  answers: widget.answers,
                );
              }));
            },
            child: Text(
              "Back",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: new Color(0xFF002A72)),
            ),
            color: Colors.white,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                debugPrint(rank.toString());
                if (rank.contains(null)) {
                  widget.answers[8] = "-1";
                } else {
                  widget.answers[8] = rank.toString();
                }
                return TenthQuestion(answers: widget.answers);
              }));
            },
            child: Text("Next", style: TextStyle(color: Colors.white)),
            color: new Color(0xFF002A72),
          )
        ],
      );
    } else {
      return ButtonBar(
        alignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return FormAnswers(answers: widget.answers);
              }));
            },
            child: Text(
              "Cancel",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: new Color(0xFF002A72)),
            ),
            color: Colors.white,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                debugPrint(rank.toString());
                if (rank.contains(null)) {
                  widget.answers[8] = "-1";
                } else {
                  widget.answers[8] = rank.toString();
                }
                return FormAnswers(answers: widget.answers);
              }));
            },
            child: Text("Resubmit", style: TextStyle(color: Colors.white)),
            color: new Color(0xFF002A72),
          )
        ],
      );
    }
  }
}

class TenthQuestion extends StatefulWidget {
  List<String> answers;
  bool answered;

  TenthQuestion({Key key, this.answers}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return Question10();
  }
}

class Question10 extends State<TenthQuestion> {

  final textController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('CORE'),
        backgroundColor: new Color(0xFF002A72),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.close),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MenuPage();
              }))
          ),
        ],
      ),
      body: Container(
          child: Column(children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 40, right: 40, top: 30),
              child: LinearPercentIndicator(
                animation: true,
                lineHeight: 15.0,
                animationDuration: 0,
                percent: 0.10 * 10,
                linearStrokeCap: LinearStrokeCap.roundAll,
                progressColor: Colors.greenAccent,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 40, right: 40, top: 30, bottom: 20),
              child: Text(
                "Do you know any speaker you would appreciate to listen to?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 40, right: 40, top: 30, bottom: 20),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Speaker's name",
                ),
                controller: textController,
              ),
            )
          ])),
      bottomNavigationBar: Container(
          child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: getButtons(),
          )),
    );
  }

  Widget getButtons() {
    if (widget.answers.length == 9) {
      return ButtonBar(
        alignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return NinethQuestion(
                  answers: widget.answers,
                );
              }));
            },
            child: Text(
              "Back",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: new Color(0xFF002A72)),
            ),
            color: Colors.white,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                if(textController.text.isEmpty) {
                  widget.answers.add("-1");
                }
                else {
                  widget.answers.add(textController.text);
                }
                return FormAnswers(answers: widget.answers);
              }));
            },
            child: Text("Next", style: TextStyle(color: Colors.white)),
            color: new Color(0xFF002A72),
          )
        ],
      );
    } else if (widget.answers.length == 9) {
      return ButtonBar(
        alignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return NinethQuestion(
                  answers: widget.answers,
                );
              }));
            },
            child: Text(
              "Back",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: new Color(0xFF002A72)),
            ),
            color: Colors.white,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                if(textController.text.isEmpty) {
                  widget.answers[9] = "-1";
                }
                else {
                  widget.answers[9] = textController.text;
                }
                return FormAnswers(answers: widget.answers);
              }));
            },
            child: Text("Next", style: TextStyle(color: Colors.white)),
            color: new Color(0xFF002A72),
          )
        ],
      );
    } else {
      return ButtonBar(
        alignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return FormAnswers(answers: widget.answers);
              }));
            },
            child: Text(
              "Cancel",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: new Color(0xFF002A72)),
            ),
            color: Colors.white,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                if(textController.text.isEmpty) {
                  widget.answers[9] = "-1";
                }
                else {
                  widget.answers[9] = textController.text;
                }
                return FormAnswers(answers: widget.answers);
              }));
            },
            child: Text("Resubmit", style: TextStyle(color: Colors.white)),
            color: new Color(0xFF002A72),
          )
        ],
      );
    }
  }
}
