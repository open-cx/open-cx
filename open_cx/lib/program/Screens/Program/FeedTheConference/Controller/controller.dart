import '../Model/Database.dart';
import 'dart:math';

import '../Util/Date.dart';
import '../Util/Question.dart';
import 'package:flutter/material.dart';

import 'package:jiffy/jiffy.dart';


//To be implemented by each view
abstract class EventBox extends StatelessWidget
{
  final String eventTitle;
  final String sessionTitle;
  final String room;
  final DateTime beginTime;
  final DateTime endTime;
  final List<Talk>talks;
  final String conferenceName;
  final String username;
  int eventId;

  EventBox(this.conferenceName,this.eventId,this.eventTitle,this.sessionTitle,this.room,this.beginTime,this.endTime,this.talks,this.username);

  Widget build(BuildContext context);
}

abstract class SessionBox extends StatelessWidget {

  final String sessionTitle;
  final String room;
  final DateTime beginTime;
  final DateTime endTime;
  final List<Talk> talks;
  final String eventTitle;

  SessionBox(this.eventTitle, this.sessionTitle, this.room, this.beginTime,
      this.endTime, this.talks);
}


class Controller
{
  Database db = new Database();

  //Getters
  List<Conference> getConferenceList()
  {
    return db.conferenceList;
  }

  List<Event> getEventList()
  {
    return db.eventList;
  }

  List<Session> getSessionList()
  {
    return db.sessionList;
  }

  List<Talk> getTalkList()
  {
    return db.talkList;
  }

  List<FormTalk> getFormList()
  {
    return db.formList;
  }

  List<FormQuestion> getFormQuestionList()
  {
    return db.formQuestionList;
  }

  List<User> getUserList()
  {
    return db.userList;
  }

  List<Attendee> getAttendeeList()
  {
    return db.attendeeList;
  }

  List<Organizer> getOrganizerList()
  {
    return db.organizerList;
  }

  List<Speaker> getSpeakerList()
  {
    return db.speakerList;
  }

  List<Response> getResponseList()
  {
    return db.responseList;
  }

  List<Rate> getRateList()
  {
    return db.rateList;
  }

  String get_name_from_username(String username){
    for(var i = 0; i < db.userList.length; i++){
      if(db.userList[i].userName == username){
        return db.userList[i].name;
      }
    }
  }

  int getIdfromusername(String username){
    for(var i = 0; i < db.userList.length; i++){
      if(db.userList[i].userName == username){
        return db.userList[i].id;
      }
    }
  }

  String get_email_from_username(String username){
    for(var i = 0; i < db.userList.length; i++){
      if(db.userList[i].userName == username){
        return db.userList[i].email;
      }
    }
  }

  user_type get_permissions_from_username(String username){
    for(var i = 0; i < db.userList.length; i++){
      if(db.userList[i].userName == username){
        return db.userList[i].userType;
      }
    }
  }

  // Functions that change the db
  int numberDaysOfConference(int conferenceId){

    DateTime begin;
    DateTime end;

    for(int i = 0; i < db.conferenceList.length; i++){
      if(conferenceId == db.conferenceList[i].id){
        begin = db.conferenceList[i].beginDate;
        end = db.conferenceList[i].endDate;
        break;
      }
    }

    Duration difference = end.difference(begin);
    return  (difference.inDays + 1);
  }


  List<Talk> talkListForASession(int sessionId){

    List<Talk> talkList = new List();
    for(int i = 0; i < db.sessionList.length; i++){
      if(db.sessionList[i].id == sessionId){
        for(int j = 0; j < db.sessionList[i].talkIdList.length; j++){
          for(int h = 0; h < db.talkList.length; h++){
            if(db.sessionList[i].talkIdList[j] == db.talkList[h].id){
              talkList.add(db.talkList[h]);
            }
          }
        }
        break;
      }
    }

    talkList.sort((a, b) =>
    (a.beginTime.toString().compareTo(b.beginTime.toString())));

    return talkList;
  }

  List<Session> sessionListForAEvent(int eventId){

    List<Session> sessionList = new List();
    Event event = getEventFromId(eventId);

    for(int j = 0; j < event.sessionIdList.length; j++){
      for(int h = 0; h < db.sessionList.length; h++){
        if(event.sessionIdList[j] == db.sessionList[h].id){
          sessionList.add(db.sessionList[h]);
        }
      }
    }
    sessionList.sort((a, b) =>
    (a.beginTime.toString().compareTo(b.beginTime.toString())));

    return sessionList;
  }

  void printSessionList(List <Session> s){

    for(int i = 0; i < s.length; i++){
      print(s[i].beginTime.toString());
    }

  }

  Event getEventFromId(int eventId){

    Event event;

    for(int i = 0; i < db.eventList.length; i++){
      if(db.eventList[i].id == eventId){
        event = db.eventList[i];
        break;
      }
    }
    return event;
  }


  List<String> getSubQuestionText(var questionId) {
    for (int i = 0; i < db.formQuestionList.length; i++) {
      if (db.formQuestionList[i].id == questionId) {
        return db.formQuestionList[i].questionSubText;
      }
    }
  }

  String getQuestionText(var questionId) {
    for (int i = 0; i < db.formQuestionList.length; i++) {
      if (db.formQuestionList[i].id == questionId) {
        return db.formQuestionList[i].questionText;
      }
    }
  }

  QuestionType getQuestionType(var questionId) {
    for (int i = 0; i < db.formQuestionList.length; i++) {
      if (db.formQuestionList[i].id == questionId) {
        return db.formQuestionList[i].type;
      }
    }
  }

  String getUsernameFromId(int personId) {
    String name;

    for (int i = 0; i < db.userList.length; i++) {
      if (db.userList[i].id == personId) {
        name = db.userList[i].userName;
        break;
      }
    }
    return name;
  }

  String getAnswerPercentageTextBox(int questionId) {
    int numberOfR = numberOfResponses(questionId);
    int numberOfBlankR = numberOfBlankResponses(questionId);
    double percentageTextBox = (numberOfR - numberOfBlankR) / numberOfR;
    percentageTextBox = percentageTextBox * 100;

    return percentageTextBox.toStringAsFixed(2).toString();
  }

  int numberOfResponses(int questionId) {
    int counter = 0;

    for (int i = 0; i < db.responseList.length; i++) {
      if (db.responseList[i].questionId == questionId) {
        counter++;
      }
    }

    return counter;
  }

  int numberOfBlankResponses(int questionId) {
    int counter = 0;

    for (int i = 0; i < db.responseList.length; i++) {
      if (db.responseList[i].questionId == questionId) {
        if (db.responseList[i].response == null ||
            db.responseList[i].response == "") counter++;
      }
    }

    return counter;
  }

  int numberOfFavorableResponses(int questionId, String response) {
    QuestionType type = getQuestionType(questionId);
    int counter = 0;

    if (type == QuestionType.checkBox) {
      for (int i = 0; i < db.responseList.length; i++) {
        for (int j = 0; j < db.responseList[i].response.length; j++) {
          if (db.responseList[i].response[j] == response) {
            counter++;
          }
        }
      }
    } else if (type == QuestionType.radioButton) {
      for (int i = 0; i < db.responseList.length; i++) {
        if (db.responseList[i].response == response) {
          counter++;
        }
      }
    }
    return counter;
  }

  String questionAnswerPercentage(int questionId, var response) {
    int numberOfResponsesForQuestion = numberOfResponses(questionId);
    int numberOfFavorableResponsesForQuestion =
    numberOfFavorableResponses(questionId, response);
    double percentage =
        numberOfFavorableResponsesForQuestion / numberOfResponsesForQuestion;
    percentage = percentage * 100;
    return percentage.toStringAsFixed(2).toString();
  }

  int numberOfNotBlankquestionResponses(int questionId) {
    @override

    int counter = 0;

    for (int j = 0; j < db.responseList.length; j++) {
      if(db.responseList[j].questionId == questionId) {
        if(db.responseList[j].response != ""){
          counter++;
        }
      }
    }
    return counter;
  }

  List<Response> questionResponses(int questionId) {
    @override
    List<Response> responsesList = new List();

    for (int j = 0; j < db.responseList.length; j++) {
      if(db.responseList[j].questionId == questionId) {
        responsesList.add(db.responseList[j]);
      }
    }
    return responsesList;
  }



  int numberOfPeopleSubmittedForm(int formId){

    int counter = 0;

    for(int i = 0; i < db.formList.length; i++){
      if(formId == db.formList[i].id){
        for(int j = 0; j < db.responseList.length; j++){
          if(db.responseList[j].questionId == db.formList[i].listIdFormQuestions[0])
            counter++;
        }
        break;
      }
    }
    return counter;
  }


  List <String> mostAnsweredQuestions(int formId){

    List<int> numberOFResponsesPerQuestion = new List();
    FormTalk form;
    List<String> mostAnswered = new List();

    for(int i = 0; i < db.formList.length; i++) {
      if(formId == db.formList[i].id) {
        form = db.formList[i];
        for(int j = 0; j < form.listIdFormQuestions.length; j++) {
          numberOFResponsesPerQuestion.add(numberOfNotBlankquestionResponses(form.listIdFormQuestions[j]));
        }
      }
    }

    int minNumberOfReponses = numberOFResponsesPerQuestion.reduce(max);
    int questionId;

    for(int i = 0; i < numberOFResponsesPerQuestion.length; i++){
      if(numberOFResponsesPerQuestion[i] == minNumberOfReponses){
        questionId = form.listIdFormQuestions[i];
        mostAnswered.add(getQuestionText(questionId));
      }
    }

    return mostAnswered;

  }

  List <String> leastAnsweredQuestions(int formId){

    List<int> numberOFResponsesPerQuestion = new List();
    FormTalk form;
    List<String> leastAnswered = new List();

    for(int i = 0; i < db.formList.length; i++) {
      if(formId == db.formList[i].id) {
        form = db.formList[i];
        for(int j = 0; j < form.listIdFormQuestions.length; j++) {
          numberOFResponsesPerQuestion.add(numberOfNotBlankquestionResponses(form.listIdFormQuestions[j]));
        }
      }
    }


    int minNumberOfReponses = numberOFResponsesPerQuestion.reduce(min);
    int questionId;
    for(int i = 0; i < numberOFResponsesPerQuestion.length; i++){
      if(numberOFResponsesPerQuestion[i] == minNumberOfReponses){
        questionId = form.listIdFormQuestions[i];
        leastAnswered.add(getQuestionText(questionId));
      }
    }

    return leastAnswered;
  }

  void sortConferenceList()
  {
    db.conferenceList.sort((a, b) =>
    (dateToString(a.beginDate).compareTo(dateToString(b.beginDate))));
  }

  void sortSessionList()
  {
    db.sessionList.sort((a, b) =>
    (dateToString(a.beginTime).compareTo(dateToString(b.beginTime))));
  }

  void sortTalkList()
  {
    db.talkList.sort((a, b) =>
    (dateToString(a.beginTime).compareTo(dateToString(b.beginTime))));
  }

  List<Tab> getTabList(int conferenceId) {

    List<Tab> tList = new List();
    var numberOfDays = controller.numberDaysOfConference(conferenceId);
    DateTime now;
    Conference conference;
    for(int i = 0; i < db.conferenceList.length; i++){
      if(db.conferenceList[i].id == conferenceId){
        conference = db.conferenceList[i];
        for(int j = 0; j < numberOfDays; j++){
          now = Jiffy(conference.beginDate).add(days: j); //2018-07-13 00:00:00.000
          var day = now.day;
          var month = monthOfTheYear(now);
          tList.add(Tab(text: "$day/$month"));
        }
        break;
      }
    }
    return tList;
  }


  void deletelistIdFormQuestion(int formID, int questionIndex)
  {
    db.formList[formID].listIdFormQuestions.removeAt(questionIndex);
  }

  void deleteFormQuestion(int index)
  {
    db.formQuestionList.removeAt(index);
  }

  int addFormQuestion(type, questionText, questionSubText)
  {
    int id = db.formQuestionList.length+1;
    FormQuestion fq = new FormQuestion(id, type, questionText, questionSubText);
    db.formQuestionList.add(fq);
    return id;
  }

  void addListIdFormQuestion(int formIndex, int questionID)
  {
    db.formList[formIndex].listIdFormQuestions.add(questionID);
  }

  int addRate(rating, talkID, userId)
  {
    int id = db.rateList.length + 1;
    db.rateList.add(new Rate(id, rating, talkID, userId));
    return id;
  }

  int addResponse(type, response, questionId, userId)
  {
    int id = db.responseList.length + 1;
    db.responseList.add(new Response(id, type, response, questionId, userId));
    return id;
  }

}

Controller controller = new Controller();