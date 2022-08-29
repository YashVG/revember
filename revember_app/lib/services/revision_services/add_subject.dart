import 'package:revember_app/constants/user_constants.dart';

Future addSubjectName(subjectTitle) async {
  final docRef = firestore
      .collection("revision_notes")
      .doc(username)
      .collection(subjectTitle);
  await docRef.add({});
}
