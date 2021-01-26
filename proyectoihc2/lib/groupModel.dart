import 'package:proyectoihc2/reminder.dart';

class Group{
  String groupName;
  String uidOwner;
  String id;
  List<String> Members;
  List<Reminder> reminderList = List<Reminder>();

  Group({this.groupName,this.uidOwner});
}