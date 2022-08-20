// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'package:revember_app/services/user_creation.dart';
import 'package:revember_app/components/back_button.dart';

class SignUpScreen2 extends StatefulWidget {
  static const String id = 'signup2_screen';
  @override
  State<SignUpScreen2> createState() => _SignUpScreen2State();
}

class _SignUpScreen2State extends State<SignUpScreen2> {
  late String inputtedPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GoBackButton(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Sign up continued',
                style: TextStyle(fontSize: 30.0),
              ),
              SizedBox(
                height: 20.0,
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
                  inputtedPassword = value;
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
                child: Text('Create account'),
                onPressed: () {
                  if (password == inputtedPassword) {
                    createUser(username, email, password);
                    Navigator.pushNamed(context, LoginScreen.id);
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            'Passwords do not match!',
                            style: TextStyle(color: Colors.red),
                          ),
                          content: Text('Please try again'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Okay'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
