


import '../../../../Model/Answer.dart';
import '../../../../Model/Question.dart';
import '../../../../Model/Talk.dart';
import '../../../../Model/User.dart';

abstract class DatabaseController {
  Future<Question> addQuestion(Talk talk, String content, bool anonymous);
  Future<Answer> addAnswer(Question question, String content, bool anonymous);

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
}