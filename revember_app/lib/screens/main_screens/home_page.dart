// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:revember_app/screens/initial_screens/welcome_screen.dart';
import 'package:revember_app/services/revision_services/get_subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'settings.dart';
import 'package:revember_app/constants/user_constants.dart';
import 'package:revember_app/constants/calendar_constants.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:revember_app/screens/revision_screens/subject_screen.dart';
import 'package:revember_app/constants/revision_constants.dart';
import 'package:revember_app/services/calendar_services/schedule_calc.dart';
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
  late DateTime testDate;
  late SharedPreferences prefs;
  late Map<DateTime, dynamic> selectedEvents;
  CalendarFormat format = CalendarFormat.twoWeeks;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  final TextEditingController _eventController = TextEditingController();
  final TextEditingController _eventController2 = TextEditingController();
  final TextEditingController _dateInput = TextEditingController();

  @override
  void initState() {
    super.initState();
    prefsData();
    selectedEvents = {};
    _dateInput.text = "";
    Future getUsername() async {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      user = pref.getString('username');
    }

    getData() async {
      await getUsername();
      setState(() {});
    }

    getData();
  }

  prefsData() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedEvents = Map<DateTime, dynamic>.from(
          decodeMap(json.decode(prefs.getString("events") ?? "{}")));
    });
  }

  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });
    return newMap;
  }

  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
    Map<DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }

  List<dynamic> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FloatingActionButton.extended(
                          heroTag: UniqueKey(),
                          onPressed: () => showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Add Event"),
                              content: TextFormField(
                                //_eventController is event title
                                controller: _eventController,
                              ),
                              actions: [
                                TextButton(
                                  child: const Text(
                                    "Cancel",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                ),
                                TextButton(
                                  child: const Text("Ok"),
                                  onPressed: () {
                                    if (_eventController.text.isEmpty) {
                                    } else {
                                      if (selectedEvents[selectedDay] != null) {
                                        selectedEvents[selectedDay].add(
                                          _eventController.text,
                                        );
                                      } else {
                                        selectedEvents[selectedDay] = [
                                          _eventController.text
                                        ];
                                      }
                                    }
                                    prefs.setString('events',
                                        json.encode(encodeMap(selectedEvents)));
                                    Navigator.pop(context);
                                    _eventController.clear();
                                    setState(() {});
                                    return;
                                  },
                                ),
                              ],
                            ),
                          ),
                          label: const Text("Add Event"),
                          icon: const Icon(Icons.add),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        FloatingActionButton.extended(
                          heroTag: UniqueKey(),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Add Test Date'),
                                    actions: [
                                      TextField(
                                        decoration: const InputDecoration(
                                            icon: Icon(Icons.article),
                                            labelText: 'Enter Test name'),
                                        controller: _eventController2,
                                      ),
                                      TextField(
                                        controller: _dateInput,
                                        //editing controller of this TextField
                                        decoration: const InputDecoration(
                                            icon: Icon(Icons.calendar_today),
                                            labelText: "Enter Test Date"),
                                        readOnly: true,

                                        onTap: () async {
                                          DateTime? pickedDate =
                                              await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime(2100),
                                          );

                                          if (pickedDate != null) {
                                            testDate = pickedDate;
                                            setState(
                                              () {
                                                String formattedDate =
                                                    DateFormat('dd-MM-yyyy')
                                                        .format(pickedDate);
                                                _dateInput.text = formattedDate;
                                                //set output date to TextField value.
                                              },
                                            );
                                            daysBeforeTest =
                                                getDaysBeforeTest(pickedDate);
                                          }
                                        },
                                      ),
                                      TextField(
                                        decoration: const InputDecoration(
                                            icon: Icon(Icons.question_mark),
                                            labelText:
                                                "No of revision intervals: ",
                                            hintText:
                                                "Default revision intervals: 5"),
                                        keyboardType: const TextInputType
                                            .numberWithOptions(decimal: false),
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        onChanged: (value) {
                                          if (int.tryParse(value) != null) {
                                            revisionIntervals =
                                                int.parse(value);
                                          }
                                        },
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TextButton(
                                            child: const Text(
                                              "Cancel",
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          ),
                                          TextButton(
                                            child:
                                                const Text("Generate schedule"),
                                            onPressed: () async {
                                              List revisionScheduleInNumbers =
                                                  createRevisionSchedule(
                                                      revisionIntervals,
                                                      daysBeforeTest);

                                              List<DateTime> revisionDates =
                                                  convertToDateTime(
                                                      revisionScheduleInNumbers,
                                                      testDate);

                                              for (var date in revisionDates) {
                                                print(date);
                                                if (selectedEvents[date] ==
                                                    null) {
                                                  selectedEvents[date] = [
                                                    _eventController2.text
                                                  ];
                                                } else {
                                                  selectedEvents[date].add(
                                                      _eventController2.text);
                                                }
                                                prefs.setString(
                                                    'events',
                                                    json.encode(encodeMap(
                                                        selectedEvents)));
                                              }

                                              Navigator.pop(context);
                                              _eventController2.clear();
                                              _dateInput.clear();
                                              setState(() {});
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                });
                          },
                          label: const Text("Add Test Date"),
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TableCalendar(
                      headerStyle: HeaderStyle(formatButtonVisible: false),
                      selectedDayPredicate: (DateTime date) {
                        return isSameDay(selectedDay, date);
                      },
                      onDaySelected: (DateTime selectDay, DateTime focusDay) {
                        setState(() {
                          selectedDay = selectDay;
                          focusedDay = focusDay;
                        });
                      },
                      eventLoader: _getEventsfromDay,
                      rowHeight: 50,
                      focusedDay: selectedDay,
                      firstDay: DateTime(1990),
                      lastDay: DateTime(2050),
                      calendarFormat: format,
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
                    ..._getEventsfromDay(selectedDay).map(
                      // ... is a spread operator which allows for multiple items to be inserted into a collection
                      // similar to a for i in loop and adding i to a list variable declared outside loop
                      (dynamic event) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const SizedBox(
                                width: 5,
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  event,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue),
                                onPressed: () async {
                                  var indexReference =
                                      selectedEvents[selectedDay]
                                          .indexOf(event);
                                  return showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Change event title:'),
                                        content: TextField(
                                          onChanged: (value) {
                                            event = value;
                                          },
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text('Cancel'),
                                            onPressed: () async {
                                              Navigator.pop(context);
                                            },
                                          ),
                                          TextButton(
                                            child: const Text('Change'),
                                            onPressed: () async {
                                              selectedEvents[selectedDay]
                                                  [indexReference] = event;
                                              prefs.setString(
                                                  'events',
                                                  json.encode(encodeMap(
                                                      selectedEvents)));

                                              Navigator.pop(context);
                                              setState(() {});
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: const Icon(Icons.edit),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red),
                                child: const Icon(Icons.delete),
                                onPressed: () async {
                                  // var indexReference =
                                  //     selectedEvents[selectedDay].indexOf(event);
                                  return showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Delete event?',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        content: Text(
                                            'Are you sure you want to delete $event?'),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text('Yes'),
                                            onPressed: () async {
                                              selectedEvents[selectedDay]
                                                  .remove(event);
                                              prefs.setString(
                                                  'events',
                                                  json.encode(encodeMap(
                                                      selectedEvents)));
                                              Navigator.pop(context);
                                              setState(() {});
                                            },
                                          ),
                                          TextButton(
                                            child: const Text(
                                              'No',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
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
                        ],
                      ),
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
