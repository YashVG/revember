import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

String? user;
