//Functions:
// - Percentage of words used compared to raw and concise notes
// - Number of words decreased by

// - - Note by note
// - - Overall percentage
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:revember_app/constants/revision_constants.dart';
import 'package:revember_app/constants/user_constants.dart';
import 'package:revember_app/services/revision_services/split_hypen.dart';

int countWords(String str) {
  List<String> words =
      str.split(' ').where((word) => !word.contains('-')).toList();
  return words.length;
}

wordPercentageComparison(String text1, String text2) {
  //outputs number of concise notes compared to raw notes in a %
  List output = [];
  List processedText1 = splitByHyphen(text1);
  List processedText2 = splitByHyphen(text2);
  output.add([processedText1, processedText2]);
  output = output[0];
  int count1 = countWords(output[0][0]);
  int count2 = countWords(output[1][0]);
  return (count2 / count1) * 100;
}

wordComparison(String text1, String text2) {
  List output = [];
  List processedText1 = splitByHyphen(text1);
  List processedText2 = splitByHyphen(text2);
  output.add([processedText1, processedText2]);
  output = output[0];

  int count1 = countWords(output[0][0]);
  int count2 = countWords(output[1][0]);
  return count1 - count2;
}

Future uploadPercentage(stats) async {
  final docRef = firestore
      .collection('statistics')
      .doc(currentTopicHash)
      .collection('stats')
      .doc('simple_stats');

  await docRef.update(
    {
      "stats": FieldValue.arrayUnion([stats])
      //adds stats for each set of notes uploaded
    },
  );
}

Future uploadComparison(stats) async {
  final docRef = firestore
      .collection('statistics')
      .doc(currentTopicHash)
      .collection('stats')
      .doc('simple_stats');
  await docRef.update(
    {
      "stats2": FieldValue.increment(stats)
      //adds stats for each set of notes uploaded
    },
  );
}
