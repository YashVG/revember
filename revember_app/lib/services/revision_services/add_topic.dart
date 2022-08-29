import 'package:revember_app/constants/user_constants.dart';

Future addSubjectAndTopic(String subjectName, String? topicName) async {
  final docRef = firestore
      .collection("revision_notes")
      .doc(username)
      .collection(subjectName)
      .doc(topicName);
  await docRef.set({});
}
