// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'signup_screen.dart';
import 'home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String username;
  late String password;
  //late modifier means that the variable is initialized at runtime rather than compile time

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
                'Login',
                style: TextStyle(fontSize: 30.0),
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  username = value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter your username',
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                onChanged: ((value) => password = value),
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                child: Text('Login'),
                onPressed: () {
                  Navigator.pushNamed(context, HomePage.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
