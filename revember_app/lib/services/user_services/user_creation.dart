import 'package:firebase_auth/firebase_auth.dart';
import 'package:revember_app/constants/user_constants.dart';

late String username;
late String email;
late String password;

Future<User?> createUser(String username, String email, String password) async {
  try {
    firestore.collection('users').add(
      {
        'email': email,
        'password': password,
        'username': username,
      },
    );
  } catch (e) {
    return null;
  }
  return null;
}

Future checkDuplicateUsername(String username) async {
  var query = await firestore
      .collection('users')
      .where('username', isEqualTo: username)
      .get();
  if (query.docs.isNotEmpty) {
    return true;
  } else {
    return false;
  }
}
