// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:revember_app/screens/initial_screens/welcome_screen.dart';
import 'settings.dart';
import 'package:revember_app/constants.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_page';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(size.height * 0.05),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            //evenly spaces out widgets in the Row
            children: [
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Logout Confirmation'),
                        content: Text('Do you want to logout?'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('No'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          TextButton(
                            child: Text('Yes'),
                            onPressed: () {
                              username = '';
                              Navigator.pushNamed(context, WelcomeScreen.id);
                              //TODO: add functionality to delete all the downloaded notes from the user's device when they logout
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Row(
                  children: [
                    Icon(Icons.logout),
                    SizedBox(width: 10),
                    Text('Logout'),
                  ],
                ),
              ),
              Text(
                'Hi $username, get started on your revision!',
                style: TextStyle(fontSize: size.aspectRatio * 15),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, SettingsScreen.id);
                },
                child: Row(
                  children: [
                    Icon(Icons.settings),
                    SizedBox(width: 10),
                    Text('Settings'),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text('Calendar'),
                  // Calendar(),
                ],
              ),
              Column(
                children: [
                  Text('Revision'),
                ],
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
