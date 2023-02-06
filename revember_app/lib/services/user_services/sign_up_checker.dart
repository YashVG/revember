//the usernameChecker is a series of conditions that the user's inputted
//username has to meet to be accepted as a conventional username

usernameChecker(String username) {
  //converts string to list, then removes repeated characters with set
  //checks how many unqiue characters are present in username
  final list = username.split('');
  final listSet = {...list};

  // checks lengths of username
  if (username.length <= 8) {
    return false;
  }
  //checks how many unqiue characters are present in username
  else if (listSet.length <= 4) {
    return false;

    //once passed, validate by returning true
  } else {
    return true;
  }
}

emailChecker(String email) {
  //simple ReGex function to check for valid email
  //if valid, return true else false
  final bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);

  return emailValid;
}
