import 'package:revember_app/constants/user_constants.dart';

Future loginUser(String username, String password) async {}

Future checkPassword(String username, String password) async {
  var user =
      firestore.collection('users').where('username', isEqualTo: username);
  var query = await user.get();
  if (query.docs.isNotEmpty) {
    var user = query.docs.first.data();
    if (user['password'] == password) {
      return true;
    } else {
      return false;
    }
  }
}
