import 'package:firebase_auth/firebase_auth.dart';
import 'package:revember_app/constants.dart';

late String username;
late String email;
late String password;

Future<User?> createUser(String username, String email, String password) async {
  try {
    firestore.collection('users').add({
      'email': email,
      'password': password,
      'username': username,
    });
  } catch (e) {
    return null;
    //TODO: find suitable way to prompt error message in app if user creation fails for whatever reason
  }
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

Future<User?> test(String username, String email, String password) async {
  try {
    firestore.collection('tests').add({'username': username});
    firestore
        .collection('test')
        .doc(username)
        .collection('private')
        .doc('password')
        .set({'password': password});
    firestore
        .collection('test')
        .doc(username)
        .collection('private')
        .doc('email')
        .set({'email': email});
  } catch (e) {
    return null;
  }
}
