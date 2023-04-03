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
import 'package:revember_app/screens/calendar_screens/calendar_phone.dart';

import 'dart:io' show Platform;

class HomePage extends StatefulWidget {
  static const String id = 'home_page';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
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

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (Platform.isIOS || Platform.isAndroid) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: AppBar(
            actions: [
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
                              sharedPreferences.setBool('isLoggedIn', false);
                              user = '';
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
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, SettingsScreen.id);
                },
                child: Row(
                  children: [
                    Icon(Icons.settings),
                    SizedBox(width: 10),
                  ],
                ),
              ),
            ],
            title: Text(
              'Revember 📖',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: GridView.count(
                crossAxisSpacing: size.width * 0.03,
                mainAxisSpacing: size.height * 0.03,
                padding: EdgeInsets.only(top: 24, left: 24, right: 24),
                shrinkWrap: false,
                crossAxisCount: 2,
                children: [
                  Expanded(
                    child: ElevatedButton(
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
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          actions: [
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
                            sharedPreferences.setBool('isLoggedIn', false);
                            user = '';
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
                  SizedBox(width: 10),
                  Text('Logout'),
                ],
              ),
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
          title: Row(
            children: [
              Text('Hi $user, get started on your revision 📖'),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(size.height * 0.05),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    TableCalendar(
                      selectedDayPredicate: (DateTime date) {
                        return isSameDay(selectedDay, date);
                      },
                      onDaySelected: (DateTime selectDay, DateTime focusDay) {
                        setState(() {
                          selectedDay = selectDay;
                          focusedDay = focusDay;
                        });
                      },
                      rowHeight: 50,
                      focusedDay: DateTime.now(),
                      firstDay: DateTime(now.year),
                      lastDay: DateTime.utc(2030, 3, 14),
                      calendarFormat: format,
                      onFormatChanged: (CalendarFormat _format) {
                        setState(() {
                          format = _format;
                        });
                      },
                      calendarStyle: CalendarStyle(
                        isTodayHighlighted: true,
                        selectedDecoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        selectedTextStyle: const TextStyle(color: Colors.white),
                        todayDecoration: BoxDecoration(
                          color: Colors.purpleAccent,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        defaultDecoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        weekendDecoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        FloatingActionButton(onPressed: null),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50), // NEW
                        ),
                        onPressed: () async {
                          await getSubjects();
                          Navigator.pushNamed(context, SubjectScreen.id);
                        },
                        child: Text('Revision'),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50), // NEW
                        ),
                        onPressed: () async {},
                        child: Text('Statistics'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
