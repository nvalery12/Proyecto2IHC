import 'package:flutter/material.dart';
import 'reminder.dart';
import 'calendar.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget{
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarController calendarController;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        TableCalendar(calendarController: calendarController,)
      ],
    );
  }
}
