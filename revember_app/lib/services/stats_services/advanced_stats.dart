import 'package:revember_app/constants/user_constants.dart';

Future getAdvancedStats(currentSubject) async {
  //currentSubject -> currentTopicHash
  final docRef = await firestore
      .collection('statistics')
      .doc(currentSubject)
      .collection('stats')
      .doc('advanced_stats')
      .get();

  var returnVal = docRef.data();

  if (returnVal!['advanced_stats'] == null ||
      returnVal['advanced_stats'] == []) {
    print(returnVal['advanced_stats']);
    return [0];
  } else {
    print(returnVal['advanced_stats']);
    return returnVal['advanced_stats'];
  }
}
