import 'package:revember_app/constants/user_constants.dart';
import 'package:revember_app/constants/revision_constants.dart';
import 'package:revember_app/services/id_generator.dart';

Future addTopic(String topicName) async {
  currentTopicHash = idGenerator();
  final docRef =
      firestore.collection("revision_notes").doc(user).collection("subjects");

  docRef.doc(currentSubject).collection('notes').doc(topicName).set(
    {
      "topic_name": topicName,
      "notes": "",
      "topic_hash": currentTopicHash,
    },
  );

  final docRef2 = firestore
      .collection('revision_notes')
      .doc(user)
      .collection('subjects')
      .doc(currentSubject)
      .collection('notes')
      .doc(topicName)
      .collection('notes')
      .doc('notes');
  docRef2.set({"notes": ""});

  final docRef3 = firestore.collection('statistics').doc(currentTopicHash);
  docRef3.set({"reference": currentTopicHash});

  final docRef4 = firestore
      .collection('statistics')
      .doc(currentTopicHash)
      .collection('stats')
      .doc('simple_stats');
  docRef4.set({"stats": []});
}
