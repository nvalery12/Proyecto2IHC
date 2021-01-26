import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proyectoihc2/groupModel.dart';
import 'package:proyectoihc2/reminder.dart';

class Database {
  final String uid;

  Database(this.uid);

  final CollectionReference newPersonalReminder = FirebaseFirestore.instance.collection('users');
  final CollectionReference newGroupReminder = FirebaseFirestore.instance.collection('Groups');


  Future<void> addPersonalReminder(Reminder reminder) {
    return newPersonalReminder
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

  Future<void> getListPersonalReminder(List<Reminder> litems) async {
    var auth = uid;
    //print(auth);
    await FirebaseFirestore.instance.collection('users')
        .doc(auth)
        .collection('RecordatoriosPersonales') //RecordatoriosPersonales
        .get()
        .then((QuerySnapshot querySnapshot) =>
    {
      querySnapshot.docs.forEach((doc) {
        String titulo, subtitulo;
        Timestamp aux;
        DateTime date;
        titulo = doc.data()["Titulo"];
        subtitulo = doc.data()["subTitulo"];
        aux = doc.data()["Date"];
        date = aux.toDate();
        TimeOfDay time = TimeOfDay(hour: date.hour, minute: date.minute);
        var reminder = new Reminder(
            title: titulo,
            subTitle: subtitulo
        );
        reminder.updateDeadline(date, time);
        reminder.id = doc.id;
        litems.add(reminder);
        /*print("Este es el titulo: " + titulo + " Este es el subTitulo: " +
            subtitulo);
        print("Esta es la fecha: " + date.toString());*/
      })
    });
  }

  Future<void> getGroupName(String groupID) async {
    await FirebaseFirestore.instance
        .collection('Groups')
        .doc(groupID)
        .get()
        .then((doc){
            return doc.data()["NombreSala"];
        });
  }

  Future<void> getGroupOwnerID(String groupID) async {
    await FirebaseFirestore.instance
        .collection('Groups')
        .doc(groupID)
        .get()
        .then((doc){
      return doc.data()["uidPropietaro"];
    });
  }

  Future<void> createGroup(Group group) async{
    DocumentReference docRef = FirebaseFirestore.instance.collection('Groups').doc();
    group.id = docRef.id;
    print(docRef.id);
    docRef.set(
      {
        'ownerUID': group.uidOwner,
        'groupName': group.groupName,
      }
    );
  }

  Future<void> addGroupReminder(Reminder reminder,Group group) async{
    return newGroupReminder
        .doc(group.id)
        .collection('Reminders')
        .add({
      'Titulo': reminder.title,
      'subTitulo': reminder.subTitle,
      'Date': reminder.deadLine,
    })
        .then((value) => print("Group Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

}
