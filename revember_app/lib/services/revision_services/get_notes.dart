import 'package:revember_app/constants/revision_constants.dart';
import 'package:revember_app/constants/user_constants.dart';

Future getNotes() async {
  final docRef = await firestore
      .collection('revision_notes')
      .doc(user)
      .collection('subjects')
      .doc(currentSubject)
      .collection('notes')
      .doc(currentTopic)
      .collection('notes')
      .doc('notes')
      .get();
  var ref = docRef.data();
  return ref!['notes'];
}
