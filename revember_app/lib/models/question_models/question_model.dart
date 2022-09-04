import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:revember_app/constants/user_constants.dart';
import 'dart:convert';

class UserQuestion {
  String? questionID;
  QuestionAnswer answerChoices;

  UserQuestion({this.questionID});
}

class QuestionAnswer {
  String? question;
  String? answer1;
  String? answer2;
  String? answer3;
  String? answer4;
  QuestionAnswer(
      {this.question, this.answer1, this.answer2, this.answer3, this.answer4});

  factory QuestionAnswer 
}
