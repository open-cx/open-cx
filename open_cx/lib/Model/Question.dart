
import 'Comment.dart';
import 'Talk.dart';
import 'User.dart';

class Question extends Comment {
  int upvotes = 0;
  int userVote = 0;
  int numComments = 1;

  bool answered = false;

  Talk talk;

  Question(this.talk, User user, String question, DateTime date) : super(user, question, date);

  void markAnswered() {
    this.answered = true;
  }

  void copyFrom(Question newQuestion) {
    this.talk = newQuestion.talk;
    this.user = newQuestion.user;
    this.date = newQuestion.date;
    this.numComments = newQuestion.numComments;
    this.userVote = newQuestion.userVote;
    this.upvotes = newQuestion.upvotes;
    this.content = newQuestion.content;
  }
  
  void downvote() {
    if (userVote == 1)
      upvotes -= 2;
    else if (userVote == -1)
      upvotes++;
    else upvotes--;
    userVote = (userVote == -1) ? 0 : -1;
  }

  void upvote() {
    if (userVote == 1)
      upvotes--;
    else if (userVote == -1)
      upvotes += 2;
    else upvotes++;

    userVote = (userVote == 1) ? 0 : 1;
  }

  String getCommentsString() {
    if (numComments == 1)
        return "1 comment";
    return "$numComments comments";
  }
}
