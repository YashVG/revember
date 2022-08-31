import 'package:revember_app/constants/user_constants.dart';
import 'package:revember_app/constants/revision_constants.dart';

Future addTopic(String topicName) async {
  final docRef = firestore
      .collection("revision_notes")
      .doc(username)
      .collection("subjects");

  docRef.doc(currentSubject).collection('notes').doc(topicName).set(
    {
      "topic_name": topicName,
      "notes": "",
    },
  );
}
