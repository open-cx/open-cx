import 'Comment.dart';
import 'Question.dart';
import 'User.dart';

class Answer extends Comment {
  bool bestAnswer = false;
  Question question;

  Answer(User user, String answer, DateTime date, bool anonymous, this.question): super(user, answer, date, anonymous);

  void markAsBest(bool isBest) {
    this.bestAnswer = isBest;
  }
}
