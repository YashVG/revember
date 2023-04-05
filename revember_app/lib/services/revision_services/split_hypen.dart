List<String> splitByHyphen(String str) {
  List<String> result = [];
  var temp = '';
  for (var i = 0; i < str.length; i++) {
    if (str[i] == '\n') {
      continue;
    }
    if (str[i] == '-') {
      if (temp.isNotEmpty) result.add(temp);
      temp = '-';
    } else {
      temp += str[i];
    }
  }
  if (temp.isNotEmpty) result.add(temp);
  return result;
}
