import 'package:revember_app/models/test_model.dart';
import 'package:revember_app/constants/user_constants.dart';
import 'package:revember_app/constants/revision_constants.dart';
import 'package:revember_app/services/id_generator.dart';
import 'package:revember_app/quiz_variables/variables.dart';
import 'package:collection/collection.dart';

Future getQuestionsAndAnswers(currentSubject) async {
  questions = [];
  currentAnswers = [];
  correctAnswers = [];
  int counter1 = 0;
  int counter2 = 0;
  final docRef = firestore
      .collection('user_made_questions')
      .doc(currentSubject)
      .collection('questions')
      .where('name');

  var query = await docRef.get();
  if (query.docs.isNotEmpty) {
    //gets question titles
    for (var i in query.docs) {
      if (questions.contains(i.toString()) == true) {
        continue;
      }
      questions.add(query.docs[counter1].data()['name']);
      counter1 = counter1 + 1;
    }

    //gets answer for each question, processed via array indexing
    for (var i in query.docs) {
      currentAnswers.add(query.docs[counter2].data()['answers']);
      correctAnswers.add(query.docs[counter2].data()['answers'][0]);
      counter2 = counter2 + 1;
    }

    //gets right answer for each q, always first element, tb randed l8r

  }
  // print(currentAnswers);
  // print(correctAnswers);
  List c = [];

  for (final pairs in IterableZip([currentAnswers, correctAnswers])) {
    c.add([pairs[0], pairs[1]]);
  }

  //use this for inputting correct answers, change index to 0 for answer choices only
  // for (var i = 0; i != c.length; i++) {
  //   // print(c[i][0]); //gets answer choices
  //   // print(c[i][1]); //gets correct answer

  //   if (c[i][0][0] == c[i][1]) {
  //     print('true');
  //     //pseudo method for checking correct answers
  //   }
  // }
  // print(c[0][1]);
  // print(c);
}
