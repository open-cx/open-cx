


import 'package:open_cx/Model/Review.dart';

import '../../../../Model/Answer.dart';
import '../../../../Model/Question.dart';
import '../../../../Model/Talk.dart';
import '../../../../Model/User.dart';

abstract class DatabaseController {
  Future<Question> addQuestion(Talk talk, String content);
  Future<Answer> addAnswer(Question question, String content);
  Future<Review> addReview(Talk talk, String content);


  User getCurrentUser();
  bool isAdmin();

  Future<List<Answer>> getAnswers(Question question);
  Future<List<Question>> getQuestions(Talk talk);
  Future<void> refreshQuestion(Question question);

  Future<void> setUserUpvote(Question question, int value);
  Future<int> getUserUpvote(Question question);
  Future<int> getUpvotes(Question question);

  Future<void> editQuestion(Question question, String newQuestion);
  Future<void> deleteQuestion(Question question);

  Future<void> editAnswer(Answer answer, String newAnswer);
  Future<void> deleteAnswer(Answer answer);

  Future<void> flagQuestionAsAnswered(Question question);
  Future<void> flagAnswerAsBest(Answer answer, bool isBest);

  Future<List<Review>> getReviews(Talk talk);
  Future<void> editReview(Review review, String newReview);
  Future<void> deleteReview(Review review);
}