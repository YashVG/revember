import 'package:revember_app/constants/user_constants.dart';
import 'package:revember_app/constants/revision_constants.dart';

Future uploadNotes(String notes) async {
  final docRef = firestore
      .collection('revision_notes')
      .doc(username)
      .collection('subjects')
      .doc(currentSubject)
      .collection('notes')
      .doc(currentTopic);

  docRef.update(
    {"notes": notes},
  );
}
