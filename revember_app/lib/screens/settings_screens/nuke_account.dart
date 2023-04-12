// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:revember_app/constants/user_constants.dart';
import 'package:revember_app/screens/initial_screens/welcome_screen.dart';
import 'package:revember_app/services/delete_services/clear_data.dart';
import 'package:revember_app/services/delete_services/nuke_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NukeAccount extends StatefulWidget {
  static const String id = 'nuke_account';
  const NukeAccount({super.key});

  @override
  State<NukeAccount> createState() => _NukeAccountState();
}

class _NukeAccountState extends State<NukeAccount> {
  late SharedPreferences prefs;
  late String defaultPassword;

  final TextEditingController _field1 = TextEditingController();
  final TextEditingController _field2 = TextEditingController();
  final TextEditingController _field3 = TextEditingController();

  getPassword() async {
    prefs = await SharedPreferences.getInstance();
    defaultPassword = prefs.getString('password')!;
  }

  @override
  void initState() {
    super.initState();
    getPassword();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete account'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 70.0,
              ),
              const Text(
                'Delete Account',
                style: TextStyle(fontSize: 30.0),
              ),
              const SizedBox(
                height: 70.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: 'Enter your password',
                ),
                onChanged: (value) {
                  _field1.text = value;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: 'Enter your password again',
                ),
                onChanged: (value) {
                  _field2.text = value;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_field1.text == _field2.text) {
                    if (_field2.text == defaultPassword) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text(
                              'Are you sure you want to delete your account?',
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text(
                                  'Yes',
                                  style: TextStyle(color: Colors.blue),
                                ),
                                onPressed: () async {
                                  return showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text(
                                          'User deleted, you will be re-directed to the homepage',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text('Okay'),
                                            onPressed: () async {
                                              await deleteUser(user);

                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                              final SharedPreferences
                                                  sharedPreferences =
                                                  await SharedPreferences
                                                      .getInstance();
                                              sharedPreferences
                                                  .remove('username');
                                              sharedPreferences
                                                  .remove('password');
                                              sharedPreferences.setBool(
                                                  'isLoggedIn', false);
                                              sharedPreferences.setString(
                                                  'events', '{}');
                                              user = '';
                                              Navigator.pushNamed(
                                                  context, WelcomeScreen.id);
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                              TextButton(
                                child: const Text(
                                  'No',
                                  style: TextStyle(color: Colors.red),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text(
                              'Incorrect default password!',
                              style: TextStyle(color: Colors.red),
                            ),
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
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text(
                            'Passwords do not match!',
                            style: TextStyle(color: Colors.red),
                          ),
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
                },
                child: const Text('Delete Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
