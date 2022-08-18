// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:revember_app/screens/signup_screen2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:revember_app/services/user_creation.dart';

class SignUpScreen extends StatefulWidget {
  static const String id = 'signup_screen';
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;
  late String username;
  late String password;
  late String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Sign up',
                style: TextStyle(fontSize: 30.0),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  username = value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter your desired username',
                ),
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                ),
                onChanged: (value) {
                  email = value;
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                child: Text('Continue'),
                onPressed: () {
                  if (checkDuplicateUsername(username) == true) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Username already exists'),
                          content: Text('Please choose another username'),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('Okay'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    createUser(email, password);
                    Navigator.pushNamed(context, SignUpScreen2.id);
                  }
                  Navigator.pushNamed(context, SignUpScreen2.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
