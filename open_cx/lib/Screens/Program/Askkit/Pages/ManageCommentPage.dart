import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../Model/Answer.dart';
import '../../../../Model/Question.dart';
import '../../../../Model/Talk.dart';
import '../Widgets/CustomDialog.dart';
import '../Widgets/CustomTextForm.dart';
import '../Widgets/DynamicFAB.dart';


abstract class ManageCommentPage extends StatefulWidget {
  final String title;
  final String hintText;
  final String emptyError;
  final bool edit;

  ManageCommentPage(this.hintText, this.emptyError, this.title, this.edit) : super();

  String getHeaderPrefix();
  String getHeaderSuffix();
  String initialContent();

  static final TextEditingController _controller = TextEditingController();

  @override
  State<StatefulWidget> createState() {
    return ManageCommentPageState();
  }

  static void setControllerText(String text) {
    WidgetsBinding.instance.addPostFrameCallback((_) => ManageCommentPage._controller.text = text);
  }

}

class ManageCommentPageState extends State<ManageCommentPage> {

  static final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  static bool anonymous = false;

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = Theme.of(context).textTheme.body1;
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title,
              style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            backgroundColor: Color(0xFF28316C),
            actions: <Widget>[
              FlatButton(child: Text("Submit", style: TextStyle(color: Theme.of(context).canvasColor)), onPressed: () => _onSubmitPressed(context))
            ],
          ),
          body: ListView(
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(10.0),
                child: RichText(
                  text: TextSpan(
                    style: titleStyle,
                    children: [
                      TextSpan(text: widget.getHeaderPrefix()),
                      TextSpan(text: widget.getHeaderSuffix(), style: titleStyle.copyWith(color: Theme.of(context).primaryColor)),
                    ]
                  )
                )
            ),
            Divider(height: 1.0, thickness: 1.0),
            Container(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                constraints: BoxConstraints(minHeight: 200),
                child: TextAreaForm(_formkey, ManageCommentPage._controller, widget.hintText, widget.emptyError, autofocus: true)
            )
          ],
        ),
          floatingActionButton: widget.edit ? null : FloatingActionButton(
              backgroundColor: anonymous ? Color(0xFF28316C) : Theme.of(context).canvasColor,
              onPressed: (){
                setState(() {
                  anonymous = !anonymous;
                });// Change icon and setState to rebuild
              },
              child: Icon(MdiIcons.incognito, color: anonymous ? Theme.of(context).canvasColor : Color(0xFF28316C)) //, size: size / 2),
          )
      ),
    );
  }

  void _onSubmitPressed(BuildContext context) {
    if (!_formkey.currentState.validate())
      return;
    if (ManageCommentPage._controller.text == widget.initialContent())
      Navigator.pop(context, null);
    else Navigator.pop(context, [ManageCommentPage._controller.text, anonymous]);
  }

  Future<bool> _onBackPressed(BuildContext context) {
    if (ManageCommentPage._controller.text == widget.initialContent())
      return Future<bool>.value(true);
    return CustomDialog(
          context: context,
          title: "Are you sure?",
          content: "This will discard your comment.",
          actions: <Widget>[
            FlatButton(child: Text("Cancel"), onPressed: () { Navigator.of(context, rootNavigator: true).pop(false);}),
            FlatButton(child: Text("Discard"), onPressed: () { Navigator.of(context, rootNavigator: true).pop(true); }),
          ],
    ).show() ?? false;
  }
}

class NewQuestionPage extends ManageCommentPage {
  final Talk talk;
  NewQuestionPage(this.talk) : super("Type question", "Question can't be empty", "New question", false) {
    ManageCommentPage.setControllerText("");
  }

  @override String getHeaderPrefix() => "Posting in: ";
  @override String getHeaderSuffix() => this.talk.name;
  @override String initialContent() => "";
}

class NewAnswerPage extends ManageCommentPage {
  final Question question;
  NewAnswerPage(this.question) : super("Type answer", "Answer can't be empty", "New answer", false) {
    ManageCommentPage.setControllerText("");
  }

  @override String getHeaderPrefix() => "Replying to: ";
  @override String getHeaderSuffix() => this.question.anonymous ? 'Anonymous' : this.question.user.name;
  @override String initialContent() => "";
}

class EditQuestionPage extends ManageCommentPage {
  final Question question;
  EditQuestionPage(this.question) : super("Type question", "Question can't be empty", "Edit question", true) {
    ManageCommentPage.setControllerText(this.question.content);
  }

  @override String getHeaderPrefix() => "Old question: ";
  @override String getHeaderSuffix() => this.question.content;
  @override String initialContent() => this.question.content;
}

class EditAnswerPage extends ManageCommentPage {
  final Answer answer;
  EditAnswerPage(this.answer) : super("Type answer", "Answer can't be empty", "Edit answer", true) {
    ManageCommentPage.setControllerText(this.answer.content);
  }

  @override String getHeaderPrefix() => "Old reply: ";
  @override String getHeaderSuffix() => this.answer.content;
  @override String initialContent() => this.answer.content;
}