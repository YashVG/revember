import 'package:revember_app/constants/user_constants.dart';

Future changePassword(String? username, String? password) async {
  var query = firestore.collection('users').doc(username).update(
    {'password': password},
  );
  return query;
}
