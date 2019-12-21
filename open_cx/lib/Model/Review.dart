import 'Comment.dart';
import 'Talk.dart';
import 'User.dart';


class Review extends Comment{

  Talk talk;

  Review(this.talk, User user, String body, DateTime date) : super(user, body, date);

  void copyFrom(Review newReview) {
    this.talk = newReview.talk;
    this.user = newReview.user;
    this.date = newReview.date;

    this.content = newReview.content;
  }
}