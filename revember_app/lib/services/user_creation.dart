import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final auth = FirebaseAuth.instance;
final firestore = FirebaseFirestore.instance;

Future<User?> createUser(String email, String password) async {
  try {
    var result = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    var user = result.user;
    return user;
  } catch (e) {
    print(e.toString());
    return null;
  }
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
