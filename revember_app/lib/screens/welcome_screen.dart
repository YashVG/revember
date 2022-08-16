// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'signup_screen.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Revember',
              style: TextStyle(fontSize: 30.0),
            ),
            SizedBox(
              height: 50.0,
            ),
            ElevatedButton(
              child: Text('Sign Up'),
              onPressed: () {
                Navigator.pushNamed(context, SignUpScreen.id);
              },
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
    );
  }
}
