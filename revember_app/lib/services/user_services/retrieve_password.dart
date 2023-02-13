import 'package:firebase_auth/firebase_auth.dart';
import 'package:revember_app/constants/user_constants.dart';

late String username;
late String email;
late bool confirmed;

Future sendEmail(String email, String username) async {
  try {
    final retrieved = await retrievePassword(username);
    to:
    [email];
    message:
    {
      subject:
      'DO NOT SHARE: Password information from Revember';
      text:
      'Your username: $username and your password: $retrieved';
    }
    confirmed = true;
  } catch (e) {
    confirmed = false;
  }
}

retrievePassword(String username) async {
  var query = await firestore
      .collection('users')
      .where('username', isEqualTo: username)
      .get();
  if (query.docs.isNotEmpty) {
    return query;
  } else {
    return null;
  }
}
