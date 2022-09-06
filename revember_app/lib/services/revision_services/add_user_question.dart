import 'package:revember_app/models/test_model.dart';
import 'package:revember_app/constants/user_constants.dart';
import 'package:revember_app/constants/revision_constants.dart';
import 'package:revember_app/services/id_generator.dart';

Future addUserMadeQuestion(
    userQuestion, answer1, answer2, answer3, answer4) async {
  final timestamp = idGenerator();
  final question = UserQuestion(
      name: userQuestion,
      questionID: timestamp,
      answers: [answer1, answer2, answer3, answer4],
      userGenerated: true);

  final docRef = firestore
      .collection("user_made_questions")
      .doc(currentTopicHash)
      .collection('questions')
      .doc(timestamp)
      .withConverter(
        fromFirestore: UserQuestion.fromFirestore,
        toFirestore: (UserQuestion city, options) => city.toFirestore(),
      );
  firestore
      .collection('user_made_questions')
      .doc(currentTopicHash)
      .set({"topic_hash": currentTopicHash});

  await docRef.set(question);
}
