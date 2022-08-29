import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:revember_app/constants/revision_constants.dart';
import 'package:revember_app/constants/user_constants.dart';

Future getSubjects() async {
  subjectList = [];
  int counter = 0;
  final docRef = firestore
      .collection("revision_notes")
      .doc(username)
      .collection('subjects')
      .where("subject_name");
  var query = await docRef.get();
  if (query.docs.isNotEmpty) {
    for (var i in query.docs) {
      print(query.docs[counter].data()['subject_name']);
      if (subjectList.contains(i.toString()) == true) {
        continue;
      }
      subjectList.add(query.docs[counter].data()['subject_name']);
      counter += 1;
    }
  }
}
