import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:revember_app/constants/user_constants.dart';

class User {
  final String? firstName;
  final String? lastName;
  final String? password;
  final String? email;

  User({
    this.firstName,
    this.lastName,
    this.password,
    this.email,
  });

  factory User.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return User(
      firstName: data?['first_name'],
      lastName: data?['last_name'],
      password: data?['password'],
      email: data?['email'],
      // revisionNotes: data?['revision_notes'] is Iterable
      //     ? List.from(data?['revision_notes'])
      //     : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (firstName != null) "first_name": firstName,
      if (lastName != null) "last_name": lastName,
      if (password != null) "password": password,
      if (email != null) "email": email,
    };
  }
}

Future addTestData() async {
  final user = User(
    firstName: "Yash",
    lastName: "Garg",
    password: "yash123",
    email: "yash@gmail.com",
  );
  final docRef = firestore
      .collection("cities")
      .withConverter(
        fromFirestore: User.fromFirestore,
        toFirestore: (User newUser, options) => newUser.toFirestore(),
      )
      .doc("yash123");
  await docRef.set(user);

  // Add a new document with a generated id.
  // final data = {"first_name": "Tokyo", "country": "Japan"};

  // firestore.collection("cities").add(data).then((documentSnapshot) =>
  //     print("Added Data with ID: ${documentSnapshot.id}"));
}
