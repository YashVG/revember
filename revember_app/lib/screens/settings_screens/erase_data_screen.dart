// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:revember_app/constants/user_constants.dart';
import 'package:revember_app/services/delete_services/clear_data.dart';
import 'package:revember_app/services/user_services/password_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EraseDataScreen extends StatefulWidget {
  static const String id = 'erase_data';
  const EraseDataScreen({super.key});

  @override
  State<EraseDataScreen> createState() => _EraseDataScreenState();
}

class _EraseDataScreenState extends State<EraseDataScreen> {
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
        title: const Text('Erase data'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 80.0,
              ),
              const Text(
                'Erase Data',
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
                              'Are you sure you want to erase all your data?',
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
                                          'Data erased!',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text('Okay'),
                                            onPressed: () async {
                                              await clearNotes(user);
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                  Navigator.pop(context);
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
                child: const Text('Erase Data'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
