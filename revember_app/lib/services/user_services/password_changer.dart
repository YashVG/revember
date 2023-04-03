import 'package:revember_app/constants/user_constants.dart';
import 'package:revember_app/services/user_services/user_creation.dart';

Future changePassword(String? username, String? password) async {
  var query = firestore.collection('users').doc(username).update(
    {'password': password},
  );
  return query;
}
