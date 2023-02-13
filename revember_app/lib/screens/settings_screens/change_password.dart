import 'package:flutter/material.dart';
import 'package:revember_app/components/back_button.dart';
import 'package:revember_app/preferences/themes.dart';

import '../../services/user_services/password_checker.dart';
import '../../services/user_services/user_creation.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const String id = 'change_password_page';
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const GoBackButton(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Reset Password',
                style: TextStyle(fontSize: 30.0),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                onChanged: (value) {
                  // var password = value;
                },
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: 'Enter your current password',
                ),
              ),
              TextField(
                onChanged: (value) {
                  // var inputtedPassword = value;
                },
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: 'Enter your new password',
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                child: const Text('Reset password'),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text(
                          'Password changed!',
                          style: TextStyle(color: Colors.green),
                        ),
                        content: const Text('Please try again'),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
