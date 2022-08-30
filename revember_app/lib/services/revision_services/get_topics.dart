import 'package:revember_app/constants/revision_constants.dart';
import 'package:revember_app/constants/user_constants.dart';
import 'package:revember_app/screens/revision_screens/topic_screen.dart';

Future getTopics() async {
  topicList = [];
  int counter = 0;
  final docRef = firestore
      .collection("revision_notes")
      .doc(username)
      .collection('subjects')
      .doc(currentSubject)
      .collection('notes')
      .where('topic_name');
  var query = await docRef.get();
  if (query.docs.isNotEmpty) {
    for (var i in query.docs) {
      if (topicList.contains(i.toString()) == true) {
        continue;
      }
      topicList.add(query.docs[counter].data()['topic_name']);
      counter += 1;
    }
  }
}
