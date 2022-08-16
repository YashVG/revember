// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  static const String id = 'signup_screen';
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
              TextField(
                onChanged: (value) {
                  password = value;
                },
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                ),
              ),
              TextField(
                onChanged: (value) {
                  password = value;
                },
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Confirm your password',
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                child: Text('Login'),
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
