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
  docRef4.set({"stats": [], "stats2": 0});

  final docRef5 = firestore
      .collection('statistics')
      .doc(currentTopicHash)
      .collection('stats')
      .doc('advanced_stats');
  docRef5.set({"advanced_stats": []});

  final docRef6 =
      firestore.collection('generated_questions').doc(currentTopicHash);
  docRef6.set({'topic_hash': currentTopicHash});

  final docRef7 = firestore
      .collection('generated_questions')
      .doc(currentTopicHash)
      .collection('easy_questions')
      .doc();
  docRef7.set({"name": ""});

  final docRef8 = firestore
      .collection('generated_questions')
      .doc(currentTopicHash)
      .collection('medium_questions')
      .doc();
  docRef8.set({"name": ""});

  final docRef9 = firestore
      .collection('generated_questions')
      .doc(currentTopicHash)
      .collection('hard_questions')
      .doc();
  docRef9.set({"name": ""});
}
