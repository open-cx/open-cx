import '../../../Controller/controller.dart';
import '../../../Util/Question.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// Create a Form widget.

class QuestionStatisticsPage extends StatefulWidget {
  final String title = 'Form Page';
  final int questionId;
  final String talkName;
  final int questionIndex;
  final String username;

  @override
  QuestionStatisticsPage(
      {Key key, this.questionIndex, this.talkName, this.questionId, this.username})
      : super(key: key);
  QuestionStatisticsState createState() {
    return QuestionStatisticsState();
  }
}


List<Widget>  listQuestionStatistics(BuildContext context, var questionId) {
  @override
  List<Widget> widgetsList = new List();

  String questionText = controller.getQuestionText(questionId);
  QuestionType questionType = controller.getQuestionType(questionId);

  if (questionType == QuestionType.checkBox ||
      questionType == QuestionType.radioButton) {
    List<String> questionSubText = controller.getSubQuestionText(questionId);
    QuestionType type = controller.getQuestionType(questionId);
    if (type == QuestionType.textBox) {
      widgetsList.add(Container(
          padding: EdgeInsets.only(left: 30),
          child: Text(questionText,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)
          )
      ));
    }
    widgetsList.add(SizedBox(
      height: 10,
    ));
    for (int i = 0; i < questionSubText.length; i++) {
      widgetsList.add(Container(
          margin: EdgeInsets.all(10),
          child:Text(
              questionSubText[i] + " " + controller.questionAnswerPercentage(questionId, questionSubText[i]) + "%", 
              style: TextStyle(fontWeight: FontWeight.bold)
          )
      ));
      widgetsList.add(SizedBox(
        height: 10,
      ));
    }
  } else {
    widgetsList.add(Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Text(questionText,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)
        )
    ));
    widgetsList.add(SizedBox(
      height: 10,
    ));
    widgetsList.add(Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Text(
            'Percentage of people who answered this question : ' + controller.getAnswerPercentageTextBox(questionId) + '%',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 20, color: Colors.black)
        )
    ));
    widgetsList.add(SizedBox(
      height: 25,
    ));
    widgetsList.add(Text('Answers:',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)));
    widgetsList.add(SizedBox(
      height: 10,
    ));

    var responseList = controller.getResponseList();
    for (int i = 0; i < responseList.length; i++) {
      if (responseList[i].questionId == questionId) {
        if (responseList[i].response != null && responseList[i].response != "") {
          widgetsList.add(questionTypeTextBox(
              context,
              responseList[i].response,
              controller.getUsernameFromId(responseList[i].userId)));
          widgetsList.add(SizedBox(
            height: 20,
          ));
        }
      }
    }
  }
  return widgetsList;
}

Widget questionTypeTextBox(
    BuildContext context, String response, String username) {
  return Container(
      padding: EdgeInsets.all(10),
      decoration: new BoxDecoration(
        color: Colors.grey[200],
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(username + " says: ",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            SizedBox(height: 10),
            Text(response,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 20, color: Colors.black))
          ]
      )
  );
}


// Create a corresponding State class.
// This class holds data related to the form.
class QuestionStatisticsState extends State<QuestionStatisticsPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollViewController;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return DefaultTabController(
        // Added
        length: 1, // Added
        initialIndex: 0, //Added
        child: Scaffold(
          body: buildQuestionStatisticPage(context, _scrollViewController,
              widget.questionId, widget.talkName, widget.questionIndex),
          //drawer: sideDrawer(context, widget.username), // Passed BuildContext in function.
        ));
  }
}

NestedScrollView buildQuestionStatisticPage(
    BuildContext context,
    ScrollController _scrollViewController,
    int questionId,
    String talkName,
    int questionIndex) {
  return new NestedScrollView(
      controller: _scrollViewController,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          new SliverAppBar(
            title: new Text("Question " + questionIndex.toString()),
            pinned: true,
            floating: true,
            snap: true,
            forceElevated: innerBoxIsScrolled,
          ),
        ];
      },
      body: new Scaffold(
          body: Container(
              margin: const EdgeInsets.only(top: 15.0),
              //color: Colors.amber[600],
              child: SingleChildScrollView(
                  child: new Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          listQuestionStatistics(context, questionId))))));
}
