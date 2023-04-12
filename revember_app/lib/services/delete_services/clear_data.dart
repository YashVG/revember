import 'package:revember_app/constants/user_constants.dart';

Future clearNotes(user) async {
  final docRef = firestore.collection('revision_notes').doc(user);
  await docRef.delete();

  //delete document fields, not document itself
}
