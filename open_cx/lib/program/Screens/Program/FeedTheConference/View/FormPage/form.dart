import '../../Util/Question.dart';
import 'package:flutter/material.dart';
import 'package:open_cx/program/Screens/Program/FeedTheConference/Util/Question.dart';
import '../../Controller/controller.dart';

// Create a Form widget.
class FormPage extends StatefulWidget {
  final String title = 'Form Page';
  final int formId;
  final String username;
  
  @override
  FormPage({Key key, this.formId, this.username}): super(key: key);
  
  FormPageState createState() {
    return FormPageState();
  }
}

List<Widget> listMyWidgets(var formKey, var formId, var context, var uid)
{
  @override
  List<Widget> widgetsList = new List();

  var formList = controller.getFormList();
  var formQuestionList = controller.getFormQuestionList();

  for(int i = 0; i < formList.length; i++){
    if(formList[i].id == formId){
      for(int h = 0; h < formList[i].listIdFormQuestions.length; h++){
        for(int j = 0; j < formQuestionList.length; j++){
          if(formList[i].listIdFormQuestions[h] == formQuestionList[j].id){
            widgetsList.add(QuestionText(
              formQuestionList[j].questionText));
              widgetsList.add(AnswerBox(formQuestionList[j].id, formQuestionList[j].type, formQuestionList[j].questionSubText));
              break;
          }  
        }
      }
     break;
    }
  }
  widgetsList.add(Padding(
    padding: const EdgeInsets.symmetric(vertical: 16.0),
    child: RaisedButton(
      onPressed: () {
        // Validate returns true if the form is valid, or false
        // otherwise.
        if (formKey.currentState.validate()) {

        for(int i = 0; i < widgetsList.length; i++)
        {
            if(widgetsList[i] is AnswerBox)
            {
              AnswerBox temp = widgetsList[i];

              switch(temp.type)
              {
                case QuestionType.radioButton:
                  controller.addResponse(temp.type, temp._radioValue, temp.questionID, uid);
                  break;
                case QuestionType.checkBox:
                  controller.addResponse(temp.type, temp._checkBoxValues, temp.questionID, uid);
                  break;
                case QuestionType.textBox:
                  controller.addResponse(temp.type, temp._userTextAnswer, temp.questionID, uid);
                  break;
              }
            }
        }

          Navigator.pop(context);
        }
      },
      child: Text('Submit'),
    ),
  ));

  return widgetsList;
}

class QuestionText extends StatelessWidget {
  final String questionText;
  QuestionText(this.questionText);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              questionText,
              style: TextStyle(fontSize: 22),
            )
          ],
        ),
        margin: const EdgeInsets.only(bottom: 8.0)
      //color: Colors.blue[100],
    );
  }
}

class AnswerBox extends StatefulWidget {
  QuestionType type;
  List questionSubText;
  int questionID;

  AnswerBox(this.questionID, this.type, this.questionSubText);

  int _radioValue = -1;
  List <bool> _checkBoxValues = new List();
  String _userTextAnswer;


  @override
  State<StatefulWidget> createState() => _AnswerBoxState();
}

class _AnswerBoxState extends State<AnswerBox> {

  Widget answerBox(QuestionType type, List questionSubText) {
    if (type == QuestionType.textBox) {
      return TextFormField(
        onChanged: (value) => widget._userTextAnswer = value,
        minLines: 1,
        maxLines: 4,
        decoration: new InputDecoration(
          labelText: "Your answer",
          fillColor: Colors.white,
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(25.0),
            borderSide: new BorderSide(),
          ),
          //fillColor: Colors.green
        ),
      );
    } else if (type == QuestionType.radioButton) {
      return Column(
            children: List.generate(questionSubText.length, (index) {
              return ListTile(
                title: Text(questionSubText[index]),
                leading: Radio(
                    value: index,
                    groupValue: widget._radioValue,
                    onChanged: (int e) => setState(() {widget._radioValue = e;}))
              );
            }),
          );
    } else if (type == QuestionType.checkBox) {
      return Column(
        children: List.generate(questionSubText.length, (index) {
          if(widget._checkBoxValues.length != questionSubText.length)
            widget._checkBoxValues.add(false);

          return ListTile(
              title: Text(questionSubText[index]),
              leading: Checkbox(
                  value: widget._checkBoxValues[index],
                  onChanged: (bool e) => setState(() {widget._checkBoxValues[index] = e;}))
          );
        }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Container(
        child: answerBox(widget.type, widget.questionSubText),
        margin: const EdgeInsets.only(bottom: 18.0)
      //color: Colors.blue[200],
    );
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class FormPageState extends State<FormPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollViewController;
  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return DefaultTabController(
      // Added
        length: 1, // Added
        initialIndex: 0, //Added
        child: Scaffold(
          body: buildFormPage(context, _tabController, _scrollViewController,
              _formKey,widget.formId, widget.title, widget.username),
        ));
  }
}

NestedScrollView buildFormPage(
    BuildContext context,
    TabController _tabController,
    ScrollController _scrollViewController,
    GlobalKey<FormState> _formKey, int formId,
    String title,
    String username) {
  return new NestedScrollView(
    controller: _scrollViewController,
    headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
      return <Widget>[
        new SliverAppBar(
          title: new Text(title),
          pinned: true,
          floating: true,
          snap: true,
          forceElevated: innerBoxIsScrolled,
        ),
      ];
    },
    body: new Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
            margin: const EdgeInsets.all(20.0),
            //color: Colors.amber[600],
            child: SingleChildScrollView(
                padding: const EdgeInsets.all(6),
                child: new Column(
                 // crossAxisAlignment: CrossAxisAlignment.start,
                    children: listMyWidgets(_formKey, formId, context, controller.getIdfromusername(username))
                )


            )),
      ),
    ),
  );
}
