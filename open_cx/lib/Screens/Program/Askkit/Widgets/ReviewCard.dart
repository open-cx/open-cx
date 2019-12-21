import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:open_cx/Model/Review.dart';
import 'package:open_cx/Model/User.dart';
import 'package:open_cx/Screens/Program/Askkit/Controllers/DatabaseController.dart';
import 'package:open_cx/Screens/Program/Askkit/Controllers/ModelListener.dart';
import 'package:open_cx/Screens/Program/Askkit/Controllers/UrlLauncher.dart';
import 'package:open_cx/Screens/Program/Askkit/Pages/ManageCommentPage.dart';

import 'package:open_cx/Screens/Program/Askkit/Widgets/CardTemplate.dart';
import 'package:open_cx/Screens/Program/Askkit/Widgets/CustomDialog.dart';
import 'package:open_cx/Screens/Program/Askkit/Widgets/CustomPopupMenu.dart';

import 'UserAvatar.dart';

class ReviewCard extends CardTemplate {
  final Review _review;
  final DatabaseController _dbcontroller;

  ReviewCard(ModelListener listener, this._review, this._dbcontroller) : super(listener);

  @override
  onHold(BuildContext context) {
    User currentUser = _dbcontroller.getCurrentUser();
    List<Widget> items = [];
    List<VoidCallback> actions = [];

    if (currentUser != _review.user && !_dbcontroller.isAdmin())
      return;

    if (currentUser == _review.user || _dbcontroller.isAdmin()) {
      items.add(Row(children: <Widget>[Icon(Icons.edit), Text('  Edit', style: Theme.of(context).textTheme.body1)]));
      items.add(Row(children: <Widget>[Icon(Icons.delete), Text('  Delete', style: Theme.of(context).textTheme.body1)]));
      actions.add(() => editReview(context));
      actions.add(() => deleteReview(context));
    }
    CustomPopupMenu.show(context, items: items, actions: actions);
  }


  void editReview(BuildContext context) async {
    Widget editPage = EditReviewPage(this._review);

    String body = await Navigator.push(context, MaterialPageRoute(builder: (context) => editPage));
    if (body == null)
      return;
    this._dbcontroller.editReview(this._review, body);
    this._review.content = body;
    this.listener.refreshModel(true);
  }

  void deleteReview(BuildContext context) async {
    ConfirmDialog(
        title: "Are you sure?",
        content: "This will delete your comment.",
        context: context,
        yesPressed: () async {
          await this._dbcontroller.deleteReview(_review);
          this.listener.refreshModel(true);
        } ,
        noPressed: () {}
    ).show();
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

                    UserAvatar(_review.user,
                        avatarRadius: 15.0,
                        textStyle: CardTemplate.usernameStyle(context, _review.user == _dbcontroller.getCurrentUser())
                    ),
                    Container(
                      padding: CardTemplate.contentPadding,
                      child: MarkdownBody(data: _review.content, onTapLink: UrlLauncher.launchURL),
                      alignment: Alignment.centerLeft,
                    ),
                    Divider(),
                    Row (
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(_review.getAgeString() , style: CardTemplate.dateStyle(context)),
                        Text(_review.edited ? " (edited)" : "", style: CardTemplate.editedStyle(context).copyWith(fontStyle: FontStyle.italic)),

                        Spacer(),
                      ],
                    )
                  ]
              )
          ),

        ]
    );
  }

  @override
  onClick(BuildContext context) {}

}