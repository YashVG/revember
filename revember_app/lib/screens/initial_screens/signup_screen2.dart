import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'package:revember_app/services/user_services/user_creation.dart';
import 'package:revember_app/components/back_button.dart';
import 'package:revember_app/services/user_services/password_checker.dart';

class SignUpScreen2 extends StatefulWidget {
  static const String id = 'signup2_screen';

  const SignUpScreen2({super.key});
  @override
  State<SignUpScreen2> createState() => _SignUpScreen2State();
}

class _SignUpScreen2State extends State<SignUpScreen2> {
  late String inputtedPassword;

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
                'Sign up continued',
                style: TextStyle(fontSize: 30.0),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                onChanged: (value) {
                  password = value;
                },
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: 'Enter your password',
                ),
              ),
              TextField(
                onChanged: (value) {
                  inputtedPassword = value;
                },
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: 'Confirm your password',
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                child: const Text('Create account'),
                onPressed: () {
                  if (verifyPassword(password) == false) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text(
                            'Change password!',
                            style: TextStyle(color: Colors.red),
                          ),
                          content: const Text(
                              'Ensure password has at least one uppercase, lowercase letter, number and special character'),
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
                  } else {
                    if (password == inputtedPassword) {
                      createUser(username, email, password);
                      Navigator.pushNamed(context, LoginScreen.id);
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                              'Passwords do not match!',
                              style: TextStyle(color: Colors.red),
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
