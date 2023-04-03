verifyPassword(String password) {
  String regexList =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regExp = RegExp(regexList);

  if (password.length <= 12) {
    return false;
  }
  return regExp.hasMatch(password);
}
