import 'package:revember_app/quiz_variables/variables.dart';
import 'package:collection/collection.dart';

class Question {
  final String questionText;
  final List<Answer> answersList;

  Question(this.questionText, this.answersList);
}

class Answer {
  final String answerText;
  final bool isCorrect;

  Answer(this.answerText, this.isCorrect);
}

List<Question> getQuestions() {
  List<Question> list = [];
  // contains list of questions derived from Question class

  List answerList = [];
  List<Answer> finalAnswerList = [];
  for (final pairs in IterableZip([currentAnswers, correctAnswers])) {
    answerList.add(
      [
        pairs[0],
        pairs[1],
      ],
    );
  }
  for (var i = 0; i != answerList.length; i++) {
    for (var answerChoice in answerList[i][0]) {
      if (answerChoice == answerList[i][1]) {
        finalAnswerList.add(
          Answer(answerChoice, true),
        );
      } else {
        finalAnswerList.add(
          Answer(answerChoice, false),
        );
      }
      finalAnswerList.shuffle();
    }
    list.add(
      Question(questions[i], finalAnswerList),
    );
    finalAnswerList = [];
  }
  list.shuffle();

  return list;
}
