import 'package:cloud_firestore/cloud_firestore.dart';

class AddUser{
  final String uid;

  AddUser(this.uid);
  final CollectionReference users = FirebaseFirestore.instance.collection('users');
    //CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser() {
    return users
        .doc(uid)
        .collection('RecordatoriosPersonales')
        .add({
          'uid': uid,
       })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
    }

}