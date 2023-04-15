// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:revember_app/components/back_button.dart';
import 'package:revember_app/constants/api_keys.dart';
import 'package:revember_app/constants/user_constants.dart';

import 'package:flutter/material.dart';
import 'package:revember_app/services/user_services/sign_up_checker.dart';

class LoginRecoveryScreen extends StatefulWidget {
  static const String id = 'login_recovery';

  const LoginRecoveryScreen({Key? key}) : super(key: key);

  @override
  State<LoginRecoveryScreen> createState() => _LoginRecoveryScreenState();
}

class _LoginRecoveryScreenState extends State<LoginRecoveryScreen> {
  @override
  Widget build(BuildContext context) {
    GoBackButton();
    String _username = '';
    String _email = '';

    //defined functions here so it can't be access from elsewhere, otherwise it will pose a major security risk

    Future? getPassword(username) async {
      var query = await firestore.collection('users').doc(username).get();
      if (query.data() == null) {
        return null;
      } else {
        return query.data()!['password'];
      }
    }

    void sendEmail(email, username, password) async {
      var serviceId = 'service_m4pq9ep',
          templateId = 'template_soc699a',
          userId = 'pDJxYa1m0vxlgg-yJ';
      http.post(
        Uri.parse(RECOVERY_API_KEY),
        headers: {
          'origin': 'http:localhost',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(
          {
            'service_id': serviceId,
            'user_id': userId,
            'template_id': templateId,
            'template_params': {
              'to_name': username,
              'from_name': 'Revember App',
              'message': 'Your password is: $password',
              'reply_to': HOST_EMAIL,
              'sender_email': email,
            }
          },
        ),
      );
    }

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
                onChanged: (value) {
                  _email = value;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Enter your username',
                ),
                onChanged: (value) {
                  _username = value;
                },
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: Text('Send request'),
                onPressed: () async {
                  if (emailChecker(_email) == false) {
                    return showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Email invalid'),
                          content: Text('Please input a valid email address'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Okay'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    final _password = (await getPassword(_username));
                    if (_password == null) {
                      return showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Email and username not found'),
                            content: Text(
                                'Please ensure you have created an account, or that your account details are correct'),
                            actions: <Widget>[
                              TextButton(
                                child: Text('Okay'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      sendEmail(_email, _username, _password);

                      return showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Email link sent!'),
                            content: Text('Check your inbox'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Okay'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
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
