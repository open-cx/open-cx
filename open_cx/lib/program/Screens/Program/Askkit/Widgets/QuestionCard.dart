import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../../../Model/Question.dart';
import '../../../../Model/User.dart';
import '../Controllers/DatabaseController.dart';
import '../Controllers/ModelListener.dart';
import '../Controllers/UrlLauncher.dart';
import '../Pages/AnswersPage.dart';
import '../Pages/ManageCommentPage.dart';
import 'CardTemplate.dart';
import 'CustomDialog.dart';
import 'CustomPopupMenu.dart';
import 'UserAvatar.dart';

class QuestionCard extends CardTemplate {
    final bool _clickable;
    final Question _question;
    final DatabaseController _dbcontroller;

    QuestionCard(ModelListener listener, this._question, this._clickable, this._dbcontroller) : super(listener);

    @override
    onClick(BuildContext context) {
      if (_clickable)
        Navigator.push(context, MaterialPageRoute(builder: (context) => AnswersPage(_question, listener, _dbcontroller)));
    }

    @override
    onHold(BuildContext context) {
      User currentUser = _dbcontroller.getCurrentUser();
      List<Widget> items = [];
      List<VoidCallback> actions = [];
      if (currentUser != _question.user && !_dbcontroller.isAdmin())
        return;
      if (!_question.answered) {
        items.add(Row(children: <Widget>[Icon(Icons.check), Text('  Mark as answered', style: Theme.of(context).textTheme.body1)]));
        actions.add(() => markQuestion(context));
      }
      if (currentUser == _question.user || _dbcontroller.isAdmin()) {
        items.add(Row(children: <Widget>[Icon(Icons.edit), Text('  Edit', style: Theme.of(context).textTheme.body1)]));
        items.add(Row(children: <Widget>[Icon(Icons.delete), Text('  Delete', style: Theme.of(context).textTheme.body1)]));
        actions.add(() => editQuestion(context));
        actions.add(() => deleteQuestion(context));
      }
      CustomPopupMenu.show(context, items: items, actions: actions);
    }


    @override
  Widget buildCardContent(BuildContext context) {
    return Row(
        children: <Widget>[
          Expanded(
              flex: 9,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Visibility(
                      visible: this._question.answered,
                      child: Container(
                        padding: EdgeInsets.only(bottom: 7.5),
                        child: Row(children: <Widget>[
                          Text("Answered ", style: Theme.of(context).textTheme.body1.copyWith(color: Colors.green.shade700)),
                          Icon(Icons.check, size: 16, color: Colors.green.shade700),
                        ])
                      ),
                    ),
                    UserAvatar(_question.user,
                        anonymous: this._question.anonymous,
                        avatarRadius: 15.0,
                        textStyle: CardTemplate.usernameStyle(context, _question.user == _dbcontroller.getCurrentUser())
                    ),
                    Container(
                      padding: CardTemplate.contentPadding,
                      child: MarkdownBody(data: _question.content, onTapLink: UrlLauncher.launchURL),
                      alignment: Alignment.centerLeft,
                    ),
                    Divider(),
                    Row (
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(_question.getAgeString() , style: CardTemplate.dateStyle(context)),
                        Text(_question.edited ? " (edited)" : "", style: CardTemplate.editedStyle(context).copyWith(fontStyle: FontStyle.italic)),

                        Spacer(),
                        Text(_question.getCommentsString(), style: CardTemplate.dateStyle(context)),
                      ],
                    )
                  ]
              )
          ),
          Expanded(
              flex: 1,
              child: UpvoteColumn(_question, _dbcontroller)
          )
        ]
    );
  }

  void editQuestion(BuildContext context) async {
    Widget editPage = EditQuestionPage(this._question);
    List commentTuple = await Navigator.push(context, MaterialPageRoute(builder: (context) => editPage));
    if (commentTuple == null)
      return;
    this._dbcontroller.editQuestion(this._question, commentTuple[0]);
    this._question.content = commentTuple[0];
    this.listener.refreshModel(true);
  }

  void deleteQuestion(BuildContext context) async {
    ConfirmDialog(
        title: "Are you sure?",
        content: "This will delete your comment.",
        context: context,
        yesPressed: () async {
          await this._dbcontroller.deleteQuestion(_question);
          this.listener.refreshModel(true);
        } ,
        noPressed: () {}
    ).show();
  }

  void markQuestion(BuildContext context) async {
    ConfirmDialog(
        title: "Mark question as answered?",
        content: "This action cannot be reversed.",
        context: context,
        yesPressed: () {
          this._dbcontroller.flagQuestionAsAnswered(_question);
          this._question.markAnswered();
          this.listener.refreshModel(true);
        },
        noPressed: () {}
    ).show();
  }
}

class UpvoteColumn extends StatefulWidget {
  final Question _question;
  final DatabaseController _dbcontroller;

  UpvoteColumn(this._question, this._dbcontroller);

  @override
  State<StatefulWidget> createState() => UpvoteColumnState();
}

class UpvoteColumnState extends State<UpvoteColumn> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
            onTap: () => upvote(),
            child: Icon(Icons.keyboard_arrow_up, size: 30.0, color: widget._question.userVote == 1 ? Colors.green : Theme.of(context).iconTheme.color)
        ),
        Text("${widget._question.upvotes}"),
        GestureDetector(
            onTap: () => downvote(),
            child: Icon(Icons.keyboard_arrow_down, size: 30.0, color: widget._question.userVote == -1 ? Colors.red : Theme.of(context).iconTheme.color)
        ),
      ],
    );
  }

  void upvote() async {
    setState(() {
      widget._question.upvote();
    });
    widget._dbcontroller.setUserUpvote(widget._question, widget._question.userVote);
  }

  void downvote() async {
    setState(() {
      widget._question.downvote();
    });
    widget._dbcontroller.setUserUpvote(widget._question, widget._question.userVote);
  }
}