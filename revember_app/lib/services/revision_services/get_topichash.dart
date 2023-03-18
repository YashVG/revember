import 'package:revember_app/constants/revision_constants.dart';
import 'package:revember_app/constants/user_constants.dart';

Future getTopicHash(currentTopic) async {
  final docRef = firestore
      .collection('revision_notes')
      .doc(user)
      .collection('subjects')
      .doc(currentSubject)
      .collection('notes')
      .doc(currentTopic);

  var query = await docRef.get();

  return (query.data()!['topic_hash']);
  // ! is a null check to ensure that there is a hash
}
