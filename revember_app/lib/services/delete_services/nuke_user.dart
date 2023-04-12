import 'package:revember_app/constants/user_constants.dart';

Future deleteUser(user) async {
  final docRef = firestore.collection('users').doc(user);
  await docRef.delete();
  //delete document fields, not document itself

  final docRef2 = firestore.collection('revision_notes').doc(user);
  await docRef2.delete();
}
