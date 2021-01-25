import 'package:proyectoihc2/reminder.dart';

class Group{
  String groupName;
  String uidOwner;
  List<String> Members;
  List<Reminder> reminderList;

  Group({this.groupName,this.uidOwner});
}