import 'package:revember_app/constants/user_constants.dart';
import 'package:revember_app/constants/revision_constants.dart';
import 'get_notes.dart';

Future uploadNotes(String notes) async {
  var previousNotes = await getNotes();

  final docRef = firestore
      .collection('revision_notes')
      .doc(user)
      .collection('subjects')
      .doc(currentSubject)
      .collection('notes')
      .doc(currentTopic)
      .collection('notes')
      .doc('notes');

  await docRef.update(
    {"notes": previousNotes + notes},
  );
}
