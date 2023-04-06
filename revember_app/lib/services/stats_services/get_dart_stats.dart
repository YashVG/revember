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
  if (returnVal == null) {
    return [0];
  } else {
    return returnVal['stats'];
  }
}
