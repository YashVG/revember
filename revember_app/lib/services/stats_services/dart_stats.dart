//Functions:
// - Percentage of words used compared to raw and concise notes
// - Number of words decreased by

// - - Note by note
// - - Overall percentage
import 'dart:math';
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
