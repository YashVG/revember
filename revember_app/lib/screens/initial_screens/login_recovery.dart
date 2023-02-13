// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:revember_app/services/user_services/retrieve_password.dart';

class LoginRecoveryScreen extends StatefulWidget {
  static const String id = 'login_recovery';

  const LoginRecoveryScreen({Key? key}) : super(key: key);

  @override
  State<LoginRecoveryScreen> createState() => _LoginRecoveryScreenState();
}

class _LoginRecoveryScreenState extends State<LoginRecoveryScreen> {
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
                'Login Recovery',
                style: TextStyle(fontSize: 30.0),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Enter your username',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: Text('Send request'),
                onPressed: () {
                  retrievePassword(username);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text(
                          'Email sent!',
                          style: TextStyle(color: Colors.red),
                        ),
                        content: const Text(
                            'You will shortly receive an email with your password'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Okay'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
