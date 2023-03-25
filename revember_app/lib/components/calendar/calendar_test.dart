import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:revember_app/constants/calendar_display_constants.dart';
import 'event.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:revember_app/constants/calendar_display_constants.dart';

class Calendar extends StatefulWidget {
  static const String id = 'calendar_test';

  const Calendar({super.key});
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late Map<DateTime, dynamic> selectedEvents;
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  TextEditingController _eventController = TextEditingController();
  late SharedPreferences prefs;

  @override
  void initState() {
    //TODO: add shared_pref thingy here

    super.initState();
    prefsData();
    selectedEvents = calendarDates;
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
        title: Text("Calendar"),
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

              print(selectedDay);
              print(selectedEvents[focusedDay]);
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
              selectedTextStyle: TextStyle(color: Colors.white),
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
              formatButtonTextStyle: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          ..._getEventsfromDay(selectedDay).map(
            (dynamic event) => ListTile(
              title: Text(
                event,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            child: Text('Hello'),
            onPressed: () {
              if (selectedEvents[selectedDay] == null) {
                selectedEvents[selectedDay] = ['I just wanna rock'];
                setState(() {});
                return;
              } else {
                selectedEvents[selectedDay].add('Lowkey rock');
                setState(() {});
                return;
              }
            },
          ),
          FloatingActionButton.extended(
            onPressed: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Add Event"),
                content: TextFormField(
                  //_eventController is event title
                  controller: _eventController,
                ),
                actions: [
                  TextButton(
                    child: Text("Cancel"),
                    onPressed: () => Navigator.pop(context),
                  ),
                  TextButton(
                    child: Text("Ok"),
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
            label: Text("Add Event"),
            icon: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
