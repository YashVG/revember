import 'dart:math';

import 'package:revember_app/constants/calendar_constants.dart';

final _random = Random();

double roundDouble(double value, int places) {
  num mod = pow(10.0, places);
  return ((value * mod).round().toDouble() / mod);
}

Duration getDaysBeforeTest(DateTime testDate) {
  DateTime now = DateTime.now(); //gets current time
  DateTime date = DateTime(
      now.year, now.month, now.day); //filters out seconds and milliseconds
  Duration daysBeforeTest = testDate.difference(date);
  //gets difference between two days
  return daysBeforeTest;
}

List createRevisionSchedule(int sessions, Duration differenceInDays) {
  ///sessions defines the number of revision sessions a user does
  List daysToRevise = []; //where the new schedule is created
  var counter = sessions;
  num daysBeforeTest = differenceInDays.inHours / 24;

  for (int i = 1; i != sessions; i++) {
    counter = counter - 1;
    if (daysBeforeTest > 10) {
      num value = (0.5 * pow(i, 2) + (0.5 * i)) * (daysBeforeTest / 10);
      daysToRevise.add(value);
      if (value == daysBeforeTest) {
        break;
      }
    } else {
      num value = (0.5 * pow(i, 2) + (0.5 * i)) * (10 / daysBeforeTest);
      daysToRevise.add(value);
      if (value == daysBeforeTest) {
        break;
      }
    }
  }

  for (int i = 0; i != counter; i++) {
    num max = daysToRevise.last;
    num min = daysToRevise[daysToRevise.length - 2];
    int result = (max).toInt();
    num value2 = _random.nextInt(result) + min;
    daysToRevise.add(value2);
  }
  daysToRevise.sort();

  //scale factor for squeezing test dates within given time range
  num maxDate = daysToRevise.last;
  num scaleFactor = maxDate / daysBeforeTest;

  for (int i = 0; i != daysToRevise.length; i++) {
    daysToRevise[i] = daysToRevise[i] / scaleFactor;
    daysToRevise[i] = roundDouble(daysToRevise[i], 2);
  }

  return daysToRevise;
}

List<DateTime> convertToDateTime(List doubleValues, DateTime testDate) {
  List<int> intValues = [];
  List<DateTime> dates = [];
  for (var i in doubleValues) {
    int number = i.round();
    intValues.add(number);
  }
  DateTime date = DateTime.now().toUtc();
  int year = date.year;
  int month = date.month;
  int day = date.day;
  var string = '';
  if (month.toString().length == 1 && day.toString().length == 1) {
    string = '$year-0$month-0$day 00:00:00.000Z';
  } else if (month.toString().length == 1) {
    string = '$year-0$month-$day 00:00:00.000Z';
  } else if (day.toString().length == 1) {
    string = '$year-$month-0$day 00:00:00.000Z';
  } else {
    string = '$year-$month-$day 00:00:00.000Z';
  }
  date = DateTime.parse(string).toUtc();
  //gets current time in UTC format with suitable hour formatting

  for (var number in intValues) {
    DateTime dateToAdd = date.add(Duration(days: number));
    dates.add(dateToAdd.toUtc());
  }
  return dates;
}
