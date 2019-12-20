import 'dart:async';

import 'package:flutter/material.dart';


import '../../../../Model/Answer.dart';
import '../../../../Model/Question.dart';
import '../Controllers/DatabaseController.dart';
import '../Controllers/ModelListener.dart';
import '../Widgets/AnswerCard.dart';
import '../Widgets/Borders.dart';
import '../Widgets/CardTemplate.dart';
import '../Widgets/CenterText.dart';
import '../Widgets/CustomListView.dart';
import '../Widgets/DynamicFAB.dart';
import '../Widgets/QuestionCard.dart';
import 'ManageCommentPage.dart';

class AnswersPage extends StatefulWidget {
  final Question _question;
  final ModelListener _listener;
  final DatabaseController _dbcontroller;

  AnswersPage(this._question, this._listener, this._dbcontroller);

  @override
  State<StatefulWidget> createState() {
    return AnswersPageState();
  }

}

class AnswersPageState extends State<AnswersPage> implements ModelListener {
  static final List<Color> borderColors = [
    Colors.red,
    Colors.yellow,
    Colors.green,
    Colors.blueAccent,
    Colors.purple
  ];

  List<Answer> answers = new List();

  bool showLoadingIndicator = false;
  Timer minuteTimer;
  ScrollController scrollController;

  @override void initState() {
    super.initState();
    scrollController = ScrollController();
    minuteTimer = Timer.periodic(Duration(minutes: 1), (t) { setState(() { }); });
    this.refreshModel(true);
  }

  @override void dispose() {
    minuteTimer.cancel();
    super.dispose();
  }

  Future<void> refreshModel(bool showIndicator) async {
    Stopwatch sw = Stopwatch()..start();
    setState(() { showLoadingIndicator = showIndicator; });
    await Future.wait([this.fetchQuestion(), this.fetchAnswers()]);
    if (this.mounted)
      setState(() { showLoadingIndicator = false; });
    print("Answer fetch time: " + sw.elapsed.toString());
  }

  Future<void> fetchQuestion() async {
    try {
      await widget._dbcontroller.refreshQuestion(widget._question);
    } on Error {
      Navigator.pop(context);
      widget._listener.refreshModel(true);
    }
  }

  Future<void> fetchAnswers() async {
    answers = await widget._dbcontroller.getAnswers(widget._question);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Answers",
            style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Color(0xFF28316C),
        ),
        body: getBody(),
        floatingActionButton: DynamicFAB(scrollController, () => addAnswerForm(context)),
    );
  }

  Widget getBody() {
    return Column(
        children: <Widget>[
          QuestionCard(this, widget._question, false, widget._dbcontroller),
          Divider(color: CardTemplate.shadowColor(context), thickness: 1.0, height: 1.0),
          Visibility(visible: showLoadingIndicator, child: LinearProgressIndicator()),
          Expanded(child: answerList(widget._question))
        ]
    );
  }

  Widget answerList(Question question) {
    if (answers.length == 0 && !this.showLoadingIndicator)
      return CenterText("This human needs assistance!\nLet's help him! 😃", textScale: 1.25);
    return CustomListView(
        onRefresh: () => refreshModel(false),
        controller: scrollController,
        itemCount: answers.length,
        itemBuilder: (BuildContext context, int i) {
          return Container(
              decoration: BoxDecoration(border: BorderLeft(borderColors[i % borderColors.length], 4.0)),
              child: Column(
                children: <Widget>[
                  AnswerCard(this, answers[i], widget._question.user, widget._dbcontroller),
                  Divider(color: CardTemplate.shadowColor(context), thickness: 1.0, height: 1.0),
                ],
              )
          );
       }
    );
  }

  void addAnswerForm(BuildContext context) async {
    Widget answerPage = NewAnswerPage(widget._question);
    List commentTuple = await Navigator.push(context, MaterialPageRoute(builder: (context) => answerPage));
    if (commentTuple == null)
      return;
    await widget._dbcontroller.addAnswer(widget._question, commentTuple[0], commentTuple[1]);
    refreshModel(true);
  }
}
