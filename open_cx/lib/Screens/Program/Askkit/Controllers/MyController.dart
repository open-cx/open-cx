import '../../../../Model/Answer.dart';
import '../../../../Model/Question.dart';
import '../../../../Model/Talk.dart';
import '../../../../Model/User.dart';
import '../../../MenuOpen.dart';
import 'DatabaseController.dart';


class Upvote {
  final Question question;
  final User user;
  int value;
  Upvote(this.question, this.user, this.value);
}

class MyController implements DatabaseController {
  static final User user1 = User("Tiago Miller", "tigasmiller@gmail.com", userThemes, "https://yt3.ggpht.com/a/AGF-l791z2rgw2RhBFQ2vnnI3wuxwMdZSNXI3U1LgQ=s176-c-k-c0x00ffffff-no-rj-mo");
  static final User user2 = User("Pedro Moas", "pedromoas@gmail.com", userThemes, "https://yt3.ggpht.com/a/AGF-l791z2rgw2RhBFQ2vnnI3wuxwMdZSNXI3U1LgQ=s176-c-k-c0x00ffffff-no-rj-mo");

  static List<User> admins = [user2];
  static User currentUser = user1;

  static List<Question> questions = new List();
  static List<Answer> answers = new List();
  static List<Upvote> upvotes = new List();

  @override
  Future<Answer> addAnswer(Question question, String content) {
    answers.add(new Answer(currentUser, content, DateTime.now(), question));
    return Future.value(answers[answers.length - 1]);
  }

  @override
  Future<Question> addQuestion(Talk talk, String content) {
    questions.add(new Question(talk, currentUser, content, DateTime.now()));
    return Future.value(questions[questions.length - 1]);
  }

  @override
  Future<void> deleteAnswer(Answer answer) {
    answers.remove(answer);
  }

  @override
  Future<void> deleteQuestion(Question question) {
    questions.remove(question);
  }

  @override
  Future<void> editAnswer(Answer answer, String newAnswer) {
    answer.content = newAnswer;
    answer.edited = true;
  }

  @override
  Future<void> editQuestion(Question question, String newQuestion) {
    question.content = newQuestion;
    question.edited = true;
  }

  @override
  Future<void> flagAnswerAsBest(Answer answer, bool isBest) {
    answer.bestAnswer = isBest;
  }

  @override
  Future<void> flagQuestionAsAnswered(Question question) {
    question.answered = true;
  }

  @override
  Future<List<Answer>> getAnswers(Question question) {
    List<Answer> questionAnswers = answers.where((answer) => question == answer.question).toList();
    questionAnswers.sort((answer1, answer2) {
      if (answer2.bestAnswer == answer1.bestAnswer)
        return 0;
      return answer2.bestAnswer ? 1 : -1;
    });
    return Future.value(questionAnswers);
  }

  @override
  User getCurrentUser() {
    return currentUser;
  }

  @override
  Future<List<Question>> getQuestions(Talk talk) async {
    List<Question> talkQuestions = questions.where((question) => question.talk == talk).toList();
    for (Question question in talkQuestions) {
      question.upvotes = await this.getUpvotes(question);
      question.userVote = await this.getUserUpvote(question);
      question.numComments = (await this.getAnswers(question)).length;
    }
    return questions.where((question) => question.talk == talk).toList();
  }

  @override
  Future<int> getUserUpvote(Question question) {
    List<Upvote> userUpvotes = upvotes.where((upvote) => upvote.question == question && upvote.user == currentUser).toList();
    if (userUpvotes.length == 0)
        return Future.value(0);
    return Future.value(userUpvotes[0].value);
  }

  @override
  bool isAdmin() {
    return admins.contains(currentUser);
  }

  @override
  Future<void> refreshQuestion(Question question) async {
    question.copyFrom(questions[questions.indexOf(question)]);
    question.upvotes = await this.getUpvotes(question);
    question.numComments = (await this.getAnswers(question)).length;
  }

  @override
  Future<void> setUserUpvote(Question question, int value) async {
    List<Upvote> userUpvotes = upvotes.where((upvote) => upvote.question == question && upvote.user == currentUser).toList();
    if (userUpvotes.length == 0)
        upvotes.add(Upvote(question, currentUser, value));
    else userUpvotes[0].value = value;
    question.upvotes = await this.getUpvotes(question);
  }

  @override
  Future<int> getUpvotes(Question question) {
    List<Upvote> questionUpvotes = upvotes.where((upvote) => upvote.question == question).toList();
    int sum = 0;
    questionUpvotes.forEach((upvote) => sum += upvote.value);
    return Future.value(sum);
  }
}