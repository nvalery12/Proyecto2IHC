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

  Future<void> getListPersonalReminder(List<Reminder> litems, final updateState,final done) async {
    var auth = uid;
    litems.clear();
    DateTime now= DateTime.now();
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
      });
    })
        .then((value) => litems.sort((A,B) => A.deadLine.isBefore(B.deadLine) ? 0 : 1))
        .then((value) => done())
        .then((value) => updateState())
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> createGroup(Group group) async {
    group.Members.add(uid);
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
    if(group.Members.contains(uid)){
      return;
    }
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

    void addGroupMemberWithUID(String groupUID) async{
    Group group =  await getUIDGroup(groupUID);
    addGroupMember(this.uid, group);
    return;
  }

  Future<Group> getUIDGroup(String groupID) async{
    Group group;
    await newGroupReminder
        .doc(groupID)
        .get()
        .then((DocumentSnapshot doc){
            String groupName = doc.data()['groupName'];
            String ownerUID = doc.data()['ownerUID'];
            List<String> membersArray = List.from(doc.data()['arrayMembers']);
            print("Group name: " + groupName + " ownerUID " + ownerUID);
            group = Group(
              groupName: groupName,
              uidOwner: ownerUID,
            );
            group.id = groupID;
            group.Members = membersArray;

        });
    return group;
  }

  Future<void> getListGroup(List<Group> litems, final updateState, final done) async {
    List<String> aux = List<String>();
    litems.clear();
    await newGroupReminder
        .where('arrayMembers', arrayContains: this.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        String groupName = doc.data()['groupName'];
        String ownerUID = doc.data()['ownerUID'];
        List<String> membersArray = List.from(doc.data()['arrayMembers']);
        print("Group name: " + groupName + " ownerUID " + ownerUID);
        litems.add(
            new Group(
              groupName: groupName,
              uidOwner: ownerUID,
            )
        );
        litems.last.Members = membersArray;
        litems.last.id = doc.id;
        print(litems.last.id);
      });
    })
        .then((value) => done())
        .then((value) => updateState())
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> getListGroupReminder(List<Reminder> litems, String GroupID,final updateState,final done) async{
    litems.clear();
    DateTime now= DateTime.now();
    await newGroupReminder
        .doc(GroupID)
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
        litems.add(reminder);
      });
    })
        .then((value) => litems.sort((A,B) => A.deadLine.isBefore(B.deadLine) ? 0 : 1))
        .then((value) => done())
        .then((value) => updateState())
        .catchError((error) => print("Failed to add user: $error"));
  }

}