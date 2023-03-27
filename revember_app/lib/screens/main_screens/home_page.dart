// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:revember_app/screens/calendar_screens/calendar_screen.dart';
import 'package:revember_app/screens/initial_screens/welcome_screen.dart';
import 'package:revember_app/services/revision_services/get_subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'settings.dart';
import 'package:revember_app/constants/user_constants.dart';
import 'package:revember_app/constants/calendar_constants.dart';
import 'package:revember_app/screens/calendar_screens/add_testdate.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:revember_app/screens/revision_screens/subject_screen.dart';
import 'package:revember_app/constants/revision_constants.dart';
import 'package:revember_app/services/calendar_services/schedule_calc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:revember_app/constants/calendar_constants.dart';
import 'package:revember_app/screens/calendar_screens/calendar_test.dart';

import 'dart:io' show Platform;

class HomePage extends StatefulWidget {
  static const String id = 'home_page';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Future getUsername() async {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      user = pref.getString('username');
    }

    getData() async {
      await getUsername();
      setState(() {});
    }

    getData();
    print(user);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (Platform.isIOS || Platform.isAndroid) {
      return Scaffold(
          body: Column(
        children: [
          SizedBox(
            height: 120,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            //evenly spaces out widgets in the Row
            children: [
              Text(
                'Hi $user, get started on your revision!',
                style: TextStyle(fontSize: 15),
              ),
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
                            onPressed: () async {
                              user = '';
                              final SharedPreferences sharedPreferences =
                                  await SharedPreferences.getInstance();
                              sharedPreferences.remove('username');
                              sharedPreferences.remove('password');
                              sharedPreferences.setBool('isLoggedIn', false);

                              Navigator.pushNamed(context, WelcomeScreen.id);
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
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: GridView.count(
              crossAxisSpacing: size.width * 0.03,
              mainAxisSpacing: size.height * 0.05,
              padding: EdgeInsets.only(top: 24, left: 24, right: 24),
              shrinkWrap: true,
              crossAxisCount: 2,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Calendar.id);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Text('Calendar'),
                      Icon(Icons.calendar_month_outlined),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await getSubjects();
                    Navigator.pushNamed(context, SubjectScreen.id);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Text('Revision'),
                      Icon(Icons.book),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Text('Daily Statistics'),
                      Icon(Icons.numbers_outlined),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, SettingsScreen.id);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Text('Settings'),
                      Icon(Icons.settings),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ));
    } else {
      return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(size.height * 0.05),
            child: Column(
              children: [
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
                                  onPressed: () async {
                                    final SharedPreferences sharedPreferences =
                                        await SharedPreferences.getInstance();
                                    sharedPreferences.remove('username');
                                    sharedPreferences.remove('password');
                                    sharedPreferences.setBool(
                                        'isLoggedIn', false);
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
                      child: Row(
                        children: [
                          Icon(Icons.logout),
                          SizedBox(width: 10),
                          Text('Logout'),
                        ],
                      ),
                    ),
                    Text(
                      'Hi $user, get started on your revision!',
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
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AddTestDate.id);
                      },
                      child: Text('Add test date'),
                    ),
                    // Calendar(),

                    ElevatedButton(
                      onPressed: () async {
                        await getSubjects();
                        Navigator.pushNamed(context, SubjectScreen.id);
                      },
                      child: Text('Revision'),
                    )
                  ],
                ),
                Container(
                  child: SingleChildScrollView(
                    child: TableCalendar(
                      rowHeight: 80,
                      focusedDay: DateTime.now(),
                      firstDay: DateTime(now.year),
                      lastDay: DateTime.utc(2030, 3, 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
