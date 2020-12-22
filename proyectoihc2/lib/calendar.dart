import 'package:flutter/material.dart';
import 'card_reminder.dart';
import 'reminder.dart';
import 'card_reminder_list.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget{
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  List<Reminder> litems;

  CalendarController calendarController;

  @override
  void  initState () {
    super.initState();
    calendarController =  CalendarController ();
  }

  @override
  void dispose() {
    calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      calendarController: calendarController,
    );
  }


}