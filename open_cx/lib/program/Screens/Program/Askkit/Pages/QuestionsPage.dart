import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../../Model/Question.dart';
import '../../../../Model/Talk.dart';
import '../Controllers/DatabaseController.dart';
import '../Controllers/ModelListener.dart';
import '../Widgets/CardTemplate.dart';
import '../Widgets/CenterText.dart';
import '../Widgets/CustomListView.dart';
import '../Widgets/DynamicFAB.dart';
import '../Widgets/QuestionCard.dart';
import '../Widgets/ShadowDecoration.dart';
import 'ManageCommentPage.dart';


class QuestionsPage extends StatefulWidget {
  final DatabaseController _dbcontroller;
  final Talk _talk;

  QuestionsPage(this._talk, this._dbcontroller);

  @override
  State<StatefulWidget> createState() {
    return QuestionsPageState();
  }

}

class QuestionsPageState extends State<QuestionsPage> implements ModelListener {
  List<Question> questions = new List();

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
    questions = await widget._dbcontroller.getQuestions(widget._talk);
    questions.sort((question1, question2) => question2.upvotes.compareTo(question1.upvotes));
    if (this.mounted)
      setState(() { showLoadingIndicator = false; });
    print("Question fetch time: " + sw.elapsed.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Questions",
              style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          backgroundColor: Color(0xFF28316C),
        ),
        body: getBody(),
        floatingActionButton: DynamicFAB(scrollController, () => addQuestionForm(context))
    );
  }

  Widget getBody() {
    return Column(
        children: <Widget>[
          Visibility(visible: showLoadingIndicator, child: LinearProgressIndicator()),
          Expanded(child: questionList()),
        ]
    );
  }


  Widget questionList() {
    if (questions.length == 0 && !this.showLoadingIndicator)
      return _emptyQuestionList();
    return CustomListView(
        onRefresh: () => refreshModel(false),
        controller: scrollController,
        itemCount: this.questions.length + 1,
        itemBuilder: (BuildContext context, int i) {
          if (i == 0)
            return _talkHeader();
          return Container(
              decoration: ShadowDecoration(shadowColor: CardTemplate.shadowColor(context), spreadRadius: 1.0, offset: Offset(0, 1)),
              margin: EdgeInsets.only(top: 10.0),
              child: QuestionCard(this, this.questions[i - 1], true, widget._dbcontroller)
          );
        }
    );
  }


  Widget _talkHeader() {
    return Container(
        decoration: ShadowDecoration(color: Theme.of(context).canvasColor, shadowColor: Colors.black, spreadRadius: 0.25, blurRadius: 7.5),
        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 15.0, bottom: 15.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    children: <Widget>[
                      Text(widget._talk.speakers[0], style: TextStyle(fontSize: 11), textAlign: TextAlign.left),
                      Spacer(),
                      Text("Room " + widget._talk.location, style: TextStyle(fontSize: 11), textAlign: TextAlign.left)
                    ],
                  )
              ),
              Container(
                  margin: EdgeInsets.only(bottom: 10.0),
                  child: Text(widget._talk.name, style: TextStyle(height: 1.25, fontSize: 20), textAlign: TextAlign.center)
              ),
              Container(
                  child: Text(widget._talk.information, style: TextStyle(fontSize: 15), textAlign: TextAlign.center)
              ),
            ]
        )
    );
  }

  Widget _emptyQuestionList() {
    return Column(
        children: <Widget>[
          _talkHeader(),
          Expanded(child: CenterText("Feels lonely here 😔\nBe the first to ask something!", textScale: 1.25))
        ]
    );
  }

  void addQuestionForm(BuildContext context) async {
    Widget questionPage = NewQuestionPage(widget._talk);
    String comment = await Navigator.push(context, MaterialPageRoute(builder: (context) => questionPage));
    if (comment == null)
      return;
    Question newQuestion = await widget._dbcontroller.addQuestion(widget._talk, comment);
    await widget._dbcontroller.setUserUpvote(newQuestion, 1);

    refreshModel(true);
  }
}
