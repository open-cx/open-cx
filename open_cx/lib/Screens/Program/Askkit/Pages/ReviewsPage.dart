
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:open_cx/Model/Review.dart';
import 'package:open_cx/Model/Talk.dart';
import 'package:open_cx/Screens/Program/Askkit/Controllers/DatabaseController.dart';
import 'package:open_cx/Screens/Program/Askkit/Controllers/ModelListener.dart';
import 'package:open_cx/Screens/Program/Askkit/Pages/ManageCommentPage.dart';
import 'package:open_cx/Screens/Program/Askkit/Widgets/CardTemplate.dart';
import 'package:open_cx/Screens/Program/Askkit/Widgets/CenterText.dart';
import 'package:open_cx/Screens/Program/Askkit/Widgets/CustomListView.dart';
import 'package:open_cx/Screens/Program/Askkit/Widgets/DynamicFAB.dart';
import 'package:open_cx/Screens/Program/Askkit/Widgets/ReviewCard.dart';
import 'package:open_cx/Screens/Program/Askkit/Widgets/ShadowDecoration.dart';

class ReviewsPage extends StatefulWidget {
  final Talk _talk;
  final DatabaseController _dbcontroller;

  ReviewsPage(this._talk, this._dbcontroller);

  @override
  State<StatefulWidget> createState() {
    return ReviewsPageState();
  }

}

class ReviewsPageState extends State<ReviewsPage> implements ModelListener{
  List<Review> reviews = new List();
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

    reviews = await widget._dbcontroller.getReviews(widget._talk);

    if (this.mounted)
      setState(() { showLoadingIndicator = false; });
    print("Review fetch time: " + sw.elapsed.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Reviews",
            style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Color(0xFF28316C),
        ),
        body: getBody(),
        floatingActionButton: DynamicFAB(scrollController, () => addReviewForm(context))
    );
  }

  Widget getBody() {
    return Column(
        children: <Widget>[
          Visibility(visible: showLoadingIndicator, child: LinearProgressIndicator()),
          Expanded(child: reviewList()),
        ]
    );
  }

  Widget reviewList() {
    if (reviews.length == 0 && !this.showLoadingIndicator)
      return _emptyReviewsList();
    return CustomListView(
        onRefresh: () => refreshModel(false),
        controller: scrollController,
        itemCount: this.reviews.length + 1,
        itemBuilder: (BuildContext context, int i) {
          if (i == 0)
            return _talkHeader();
          return Container(
              decoration: ShadowDecoration(shadowColor: CardTemplate.shadowColor(context), spreadRadius: 1.0, offset: Offset(0, 1)),
              margin: EdgeInsets.only(top: 10.0),
              child: ReviewCard(this, this.reviews[i - 1], widget._dbcontroller)
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


  Widget _emptyReviewsList() {
    return Column(
        children: <Widget>[
          _talkHeader(),
          Expanded(child: CenterText("Feels lonely here 😔\n Be the first to make a review!", textScale: 1.25))
        ]
    );
  }


  void addReviewForm(BuildContext context) async {
    Widget reviewPage = NewReviewPage(widget._talk);
    String comment = await Navigator.push(context, MaterialPageRoute(builder: (context) => reviewPage));
    if (comment == null)
      return;
    Review newReview = await widget._dbcontroller.addReview(widget._talk, comment);

    refreshModel(true);
  }
}
