import 'package:firebase_auth/firebase_auth.dart';
import 'package:revember_app/constants/user_constants.dart';

late String username;
late String email;
late String password;

Future<User?> createUser(String username, String email, String password) async {
  final docRef = firestore.collection('users').doc(username);

  await docRef.set(
    {
      'email': email,
      'password': password,
      'username': username,
    },
  );
}

//TODO: Fix checkDuplicateUsername function so that it actually works
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
