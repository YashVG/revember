import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:revember_app/services/calendar_services/schedule_calc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:revember_app/constants/calendar_constants.dart';

class CalendarScreen extends StatefulWidget {
  static const String id = 'calendar';

  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('Calendar'),
      ),
      body: Container(
          child: SingleChildScrollView(
        child: TableCalendar(
          rowHeight: 80,
          focusedDay: DateTime.now(),
          firstDay: DateTime(now.year),
          lastDay: DateTime.utc(2030, 3, 14),
        ),
      )),
    );
  }
}
