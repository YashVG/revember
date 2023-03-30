import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:revember_app/constants/calendar_constants.dart';

import '../../services/calendar_services/schedule_calc.dart';

class Calendar extends StatefulWidget {
  static const String id = 'calendar_phone';

  const Calendar({Key? key}) : super(key: key);
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final TextEditingController _dateInput = TextEditingController();
  late Map<DateTime, dynamic> selectedEvents;
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  late DateTime testDate;
  final TextEditingController _eventController = TextEditingController();
  final TextEditingController _eventController2 = TextEditingController();
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    prefsData();
    selectedEvents = {};
    _dateInput.text = "";
  }

  prefsData() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedEvents = Map<DateTime, dynamic>.from(
          decodeMap(json.decode(prefs.getString("events") ?? "{}")));
    });
  }

  // function to convert map dtype to suitable dtype for shared preferences
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
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calendar"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: selectedDay,
            firstDay: DateTime(1990),
            lastDay: DateTime(2050),
            calendarFormat: format,
            onFormatChanged: (CalendarFormat _format) {
              setState(() {
                format = _format;
              });
            },
            startingDayOfWeek: StartingDayOfWeek.sunday,
            daysOfWeekVisible: true,

            //Day Changed
            onDaySelected: (DateTime selectDay, DateTime focusDay) {
              setState(() {
                selectedDay = selectDay;
                focusedDay = focusDay;
              });
            },
            selectedDayPredicate: (DateTime date) {
              return isSameDay(selectedDay, date);
            },

            eventLoader: _getEventsfromDay,

            //To style the Calendar
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
            headerStyle: HeaderStyle(
              formatButtonVisible: true,
              titleCentered: true,
              formatButtonShowsNext: false,
              formatButtonDecoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(5.0),
              ),
              formatButtonTextStyle: const TextStyle(
                color: Colors.white,
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
                            selectedEvents[selectedDay].indexOf(event);
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
                                    prefs.setString('events',
                                        json.encode(encodeMap(selectedEvents)));

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
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const Icon(Icons.delete),
                      onPressed: () async {
                        // var indexReference =
                        //     selectedEvents[selectedDay].indexOf(event);
                        return showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Delete event?',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              content: Text(
                                  'Are you sure you want to delete $event?'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Yes'),
                                  onPressed: () async {
                                    selectedEvents[selectedDay].remove(event);
                                    prefs.setString('events',
                                        json.encode(encodeMap(selectedEvents)));
                                    Navigator.pop(context);
                                    setState(() {});
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
                                )
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Wrap(
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
                          selectedEvents[selectedDay] = [_eventController.text];
                        }
                      }
                      prefs.setString(
                          'events', json.encode(encodeMap(selectedEvents)));
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
          const SizedBox(
            width: 25,
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
                            DateTime? pickedDate = await showDatePicker(
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
                              daysBeforeTest = getDaysBeforeTest(pickedDate);
                            }
                          },
                        ),
                        TextField(
                          decoration: const InputDecoration(
                              icon: Icon(Icons.question_mark),
                              labelText: "No of revision intervals: ",
                              hintText: "Default revision intervals: 5"),
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: false),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChanged: (value) {
                            if (int.tryParse(value) != null) {
                              revisionIntervals = int.parse(value);
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              child: const Text(
                                "Cancel",
                                style: TextStyle(color: Colors.red),
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                            TextButton(
                              child: const Text("Generate schedule"),
                              onPressed: () async {
                                List<DateTime> list = [
                                  DateTime.utc(2023, 03, 29),
                                  DateTime.utc(2023, 04, 13),
                                  DateTime.now().toUtc()
                                ];
                                List revisionScheduleInNumbers =
                                    createRevisionSchedule(
                                        revisionIntervals, daysBeforeTest);

                                List<DateTime> revisionDates =
                                    convertToDateTime(
                                        revisionScheduleInNumbers, testDate);

                                for (var date in revisionDates) {
                                  if (selectedEvents[date] == null) {
                                    selectedEvents[date] = [
                                      _eventController2.text
                                    ];
                                  } else {
                                    selectedEvents[date]
                                        .add(_eventController2.text);
                                  }
                                }

                                // for (var date in list) {
                                //   print(date);
                                //   if (selectedEvents[date] == null) {
                                //     selectedEvents[date] = ['Jelly'];
                                //   } else {
                                //     selectedEvents[date].add('Jelly2');
                                //   }
                                //   setState(() {});
                                // }

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
    );
  }
}
