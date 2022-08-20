import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:revember_app/constants.dart';

late String username;
late String email;
late String password;

Future<User?> test(String username, String email, String password) async {
  try {
    firestore.collection('users').add({
      'username': username,
    });
    var messageRef = firestore
        .collection('users')
        .doc(username)
        .collection('private')
        .doc('password');
  } catch (e) {
    return null;
  }
}
