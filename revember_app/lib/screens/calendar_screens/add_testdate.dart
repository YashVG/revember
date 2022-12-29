// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
//TODO: Fix test date page
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:revember_app/services/calendar_services/schedule_calc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:revember_app/constants/calendar_constants.dart';

class AddTestDate extends StatefulWidget {
  static const String id = 'add_test';
  const AddTestDate({Key? key}) : super(key: key);

  @override
  State<AddTestDate> createState() => _AddTestDateState();
}

class _AddTestDateState extends State<AddTestDate> {
  final TextEditingController _dateInput = TextEditingController();
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    _dateInput.text = "";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Add test date to get revision schedule"),
        backgroundColor: Colors.blueGrey, //background color of app bar
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
              left: size.width * 0.025, right: size.width * 0.025),
          child: Center(
            child: Column(
              children: [
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
                      setState(
                        () {
                          String formattedDate =
                              DateFormat('dd-MM-yyyy').format(pickedDate);
                          _dateInput.text = formattedDate;
                          //set output date to TextField value.
                        },
                      );
                      daysBeforeTest = getDaysBeforeTest(pickedDate);
                    }
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                      icon: Icon(Icons.question_mark),
                      labelText: "Enter how many times you wish to revise",
                      hintText: "Default revision intervals are set to 5"),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  onChanged: (value) {
                    if (int.tryParse(value) != null) {
                      revisionIntervals = int.parse(value);
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    revisionScheduleInInt = createRevisionSchedule(
                        revisionIntervals, daysBeforeTest);
                    print(revisionScheduleInInt);
                  },
                  child: Text('Create schedule'),
                ),
                ClipRect(
                  clipBehavior: Clip.hardEdge,
                  child: TableCalendar(
                    calendarFormat: _calendarFormat,
                    onFormatChanged: (format) {
                      if (_calendarFormat != format) {
                        setState(
                          () {
                            _calendarFormat = format;
                          },
                        );
                      }
                    },
                    availableCalendarFormats: {
                      CalendarFormat.month: 'week',
                      CalendarFormat.week: 'month'
                    },
                    rowHeight: 50,
                    focusedDay: DateTime.now(),
                    firstDay: DateTime(now.month),
                    lastDay: DateTime.utc(2030, 3, 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
