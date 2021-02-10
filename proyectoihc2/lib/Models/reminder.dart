import 'package:flutter/material.dart';

class Reminder {
  String title;
  String subTitle;
  bool isFinish;
  DateTime deadLine;
  String id;

  Reminder({this.title, this.subTitle,this.deadLine});

  void updateDeadline(DateTime newDate, TimeOfDay newTime) {
    this.deadLine = DateTime.utc(
        newDate.year, newDate.month, newDate.day, newTime.hour, newTime.minute);
  }

  String remainigTime() {
    Duration difference = deadLine.difference(DateTime.now());
    var day = difference.inDays;
    if((deadLine.day==DateTime.now().day)&&(day == 0)){
      return "Hoy";
    }
    if((deadLine.day!=DateTime.now().day)&&(day == 0)){
      day=day+1;
    }
    return "$day";
  }

  String deadLineDate() {
    var day = this.deadLine.day;
    var month = this.deadLine.month;
    var year = this.deadLine.year;
    return "$day/$month/$year";
  }

  String deadLineTime() {
    var hour = this.deadLine.hour;
    var minutes = this.deadLine.minute;
    var hourString = timeToString(hour);
    var minutesString = timeToString(minutes);
    return hourString + ":" + minutesString;
  }

  String timeToString(int time) {
    String num = time.toString();
    if (time > 9) {
      return num;
    } else {
      return "0$num";
    }
  }
}