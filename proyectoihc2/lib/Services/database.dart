import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proyectoihc2/Models/groupModel.dart';
import 'package:proyectoihc2/Models/reminder.dart';


class Database {
  final String uid;

  Database(this.uid);

  final CollectionReference newPersonalReminder = FirebaseFirestore.instance
      .collection('Users');
  final CollectionReference newGroupReminder = FirebaseFirestore.instance
      .collection('Groups');


  Future<void> addPersonalReminder(Reminder reminder) {
    return newPersonalReminder
        .doc(uid)
        .collection('Personal Reminder')
        .add({
      'Title': reminder.title,
      'subTitle': reminder.subTitle,
      'Date': reminder.deadLine,
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> getListPersonalReminder(List<Reminder> litems) async {
    var auth = uid;
    print(auth);
    await FirebaseFirestore.instance.collection('Users')
        .doc(auth)
        .collection('Personal Reminder') //RecordatoriosPersonales
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        String titulo, subtitulo;
        Timestamp aux;
        DateTime date;
        titulo = doc.data()["Title"];
        subtitulo = doc.data()["subTitle"];
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
        print("Esta es la fecha: " + date.toString());
        print("Que coño");*/
      });
    });
  }

  String getGroupName(String groupID)  {
     FirebaseFirestore.instance
        .collection('Groups')
        .doc(groupID)
        .get()
        .then((doc) {
      return doc.data()["groupName"];
    });
  }

  String getGroupOwnerID(String groupID) {
     FirebaseFirestore.instance
        .collection('Groups')
        .doc(groupID)
        .get()
        .then((doc) {
      return doc.data()["ownerUID"];
    });
  }

  Future<void> createGroup(Group group) async {
    DocumentReference docRef = FirebaseFirestore.instance.collection('Groups')
        .doc();
    group.id = docRef.id;
    print(docRef.id);
    docRef.set(
        {
          'ownerUID': group.uidOwner,
          'groupName': group.groupName,
          'arrayMembers': group.Members
        }
    );
  }

  Future<void> addGroupReminder(Reminder reminder, Group group) async {
    return newGroupReminder
        .doc(group.id)
        .collection('Reminders')
        .add({
      'Title': reminder.title,
      'subTitle': reminder.subTitle,
      'Date': reminder.deadLine,
    })
        .then((value) => print("Group Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> addGroupMember(String uid, Group group) async {
    group.Members.add(uid);
    return newGroupReminder
        .doc(group.id)
        .update({
      'arrayMembers': group.Members,
    }
    )
        .then((value) => print("Group Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> getListGroup(List<Group> litems) async {
    List<String> aux = List<String>();
    await newGroupReminder
        .where('arrayMembers', arrayContains: this.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        aux.add(doc.id);
      });
    });
    aux.forEach((element) async{
      print("Aqui: "+ element);
      litems.add(
        new Group(
          groupName:  getGroupName(element),
          uidOwner:  getGroupOwnerID(element)
        )
      );
      await newGroupReminder
          .doc(element)
          .collection('Reminders') //RecordatoriosPersonales
          .get()
          .then((QuerySnapshot querySnapshot) {
            querySnapshot.docs.forEach((doc) {
              String titulo, subtitulo;
              Timestamp aux;
              DateTime date;
              titulo = doc.data()["Title"];
              subtitulo = doc.data()["subTitle"];
              aux = doc.data()["Date"];
              date = aux.toDate();
              TimeOfDay time = TimeOfDay(hour: date.hour, minute: date.minute);
              var reminder = new Reminder(
                title: titulo,
                subTitle: subtitulo
              );
              reminder.updateDeadline(date, time);
              reminder.id = doc.id;
              litems.last.reminderList.add(reminder);
              print("litems en la ultima posicion es: " + litems.last.reminderList.last.title);
        });
      });
    });

  }
}