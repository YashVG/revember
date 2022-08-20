import 'package:revember_app/constants.dart';

Future loginUser(String username, String password) async {}

// Future<bool> checkIfUserExists(String username) async {
//   var query = await firestore
//       .collection('users')
//       .where('username', isEqualTo: username)
//       .get();
//   return query.docs.isNotEmpty;
// }

Future checkPassword(String username, String password) async {
  var user =
      firestore.collection('users').where('username', isEqualTo: username);
  var query = await user.get();
  print(query);
  if (query.docs.isNotEmpty) {
    var user = query.docs.first.data();
    print(user['password']);
    if (user['password'] == password) {
      return true;
    } else {
      return false;
    }
  }
}

Future test2(String username, String password) async {
  var query = await firestore.collection('test').doc(username);

  print(query.get());
  // if (query.get().) {
  //   var user = query.data();
  //   print(user);
  //   if (user == password) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
}
