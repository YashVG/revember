import 'package:cloud_firestore/cloud_firestore.dart';

class UserQuestion {
  final String? name;
  final String? questionID;
  final List<String>? answers;
  final bool? userGenerated;

  UserQuestion({this.name, this.questionID, this.answers, this.userGenerated});

  factory UserQuestion.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserQuestion(
        name: data?['question'],
        questionID: data?['questionID'],
        answers:
            data?['answers'] is Iterable ? List.from(data?['answers']) : null,
        userGenerated: data?['userGenerated']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (questionID != null) "questionID": questionID,
      if (answers != null) "answers": answers,
      if (userGenerated != null) "userGenerated": userGenerated
    };
  }
}
