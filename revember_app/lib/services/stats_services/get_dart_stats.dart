import 'package:revember_app/constants/user_constants.dart';

Future getDartPercentage(currentSubject) async {
  //currentSubject -> currentTopicHash
  final docRef = await firestore
      .collection('statistics')
      .doc(currentSubject)
      .collection('stats')
      .doc('simple_stats')
      .get();

  var returnVal = docRef.data();

  if (returnVal!['stats'] == null || returnVal['stats'] == []) {
    print(returnVal['stats']);
    return [0];
  } else {
    print(returnVal['stats']);
    return returnVal['stats'];
  }
}

Future getDartComparison(currentSubject) async {
  //currentSubject -> currentTopicHash
  final docRef = await firestore
      .collection('statistics')
      .doc(currentSubject)
      .collection('stats')
      .doc('simple_stats')
      .get();

  var returnVal = docRef.data();
  if (returnVal!['stats2'] == null || returnVal['stats2'] == 0) {
    // print(returnVal['stats2']);
    return 0;
  } else {
    // print(returnVal['stats2']);
    return returnVal['stats2'];
  }
}
