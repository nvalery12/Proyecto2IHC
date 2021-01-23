import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyectoihc2/reminder.dart';

class Database{
  final String uid;
  final Reminder reminder;

  Database(this.uid,this.reminder);
  final CollectionReference newReminder = FirebaseFirestore.instance.collection('users');
    //CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addReminder() {
    return newReminder
        .doc(uid)
        .collection('RecordatoriosPersonales')
        .add({
          'Titulo': reminder.title,
          'subTitulo': reminder.subTitle,
          'Date': reminder.deadLine,
       })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
    }

}