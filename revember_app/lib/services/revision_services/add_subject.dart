import 'package:revember_app/constants/user_constants.dart';
import 'package:revember_app/constants/revision_constants.dart';

Future addSubjectName(subjectTitle) async {
  final docRef = firestore
      .collection("revision_notes")
      .doc(username)
      .collection('subjects')
      .doc(subjectTitle);
  await docRef.set(
    {
      "subject_name": subjectTitle,
    },
  );
  // subjectList.add(subjectTitle);
}
