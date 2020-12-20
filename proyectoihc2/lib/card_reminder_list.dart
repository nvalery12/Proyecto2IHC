import 'package:flutter/material.dart';
import 'card_reminder.dart';
import 'reminder.dart';

class CardReminderList extends StatefulWidget{
  List<Reminder> litems;
  CardReminderList(this.litems);
  @override
  _CardReminderListState createState() => _CardReminderListState();
}

class _CardReminderListState extends State<CardReminderList> {
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return ListView.builder(
      itemCount: this.widget.litems.length,
      itemBuilder: (BuildContext ctxt, int Index) {
        return CardReminder(this.widget.litems[Index]);
      },
    );
  }
}