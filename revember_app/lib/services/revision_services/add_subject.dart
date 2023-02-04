import 'package:revember_app/constants/user_constants.dart';
import 'package:revember_app/constants/revision_constants.dart';

Future addSubjectName(subjectTitle, user) async {
  //gets user's reference to set username field in revision_notes collection
  final userRef = firestore.collection('revision_notes').doc(user);

  //needs to add username to field to username document in revision_notes collection to properly query for editing and deleting queries
  await userRef.set({
    "username": user,
  });

  //adds subject to user's document in relevant collection
  final docRef = firestore
      .collection("revision_notes")
      .doc(user)
      .collection('subjects')
      .doc(subjectTitle);

  //sets subject name to the inputting subject title in Flutter
  await docRef.set(
    {
      "subject_name": subjectTitle,
    },
  );
  // subjectList.add(subjectTitle);
}
