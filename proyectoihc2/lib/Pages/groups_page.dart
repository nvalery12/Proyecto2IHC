import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proyectoihc2/Widgets/card_group_list.dart';
import 'package:proyectoihc2/Services/database.dart';
import 'package:proyectoihc2/Models/groupModel.dart';


class GroupPage extends StatefulWidget{
  String uid;
  List<Group> liGroups = List<Group>();
  GroupPage(this.uid);
  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  bool dones=false;

  void done(){
    dones=true;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Database db = Database(this.widget.uid);
    db.getListGroup(this.widget.liGroups,updateState,done);
    /*this.widget.liGroups.forEach((element) {
      db.getListGroupReminder(element.reminderList,element.id,updateState);
    });*/

  }
  void updateState(){
    setState((){});
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        if(dones)
          if(this.widget.liGroups.isNotEmpty) CardGroupList(this.widget.liGroups,this.widget.uid,updateState)
          else Center(child: Text("Agrege nuevos grupos."),)
        else Center(child: CircularProgressIndicator()), //CardGroupList
        Align(
          alignment: Alignment.bottomRight,
          child: new FloatingActionButton(
            child: new Icon(Icons.add),
            onPressed:(){
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => SecondRoute(this.widget.liGroups,this.widget.uid,updateState)),
              );
            },
            backgroundColor: Color(0xff686d76),
          ),
        ),
      ],
    );
  }
}

class SecondRoute extends StatefulWidget {
  final updateState;
  List<Group> liGroups;
  String uid;
  Group grupo;

  SecondRoute(this.liGroups,this.uid,this.updateState,{this.grupo});
  @override
  _SecondRouteState createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {
  String titlee='Titulo';
  @override
  void initState() {
    if(this.widget.grupo!=null){
      titlee=this.widget.grupo.groupName;
    }
    super.initState();
  }

  final controllerGroupTitleText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Titulo de grupo"),
      ),
      body: Container(
        child:  Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0, top: 40.0),
              child: TextField(
                maxLength: 15,
                maxLengthEnforced: true,
                cursorColor: Colors.white,            //Color del cursor
                style: TextStyle(color: Colors.white),//Color de texto
                decoration: InputDecoration(
                  border: new OutlineInputBorder(         //Bordes redondos
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(25.0),
                    ),
                  ),
                  fillColor: Color(0xff686d76),       //Color de relleno
                  filled: true,                       //Relleno activado
                  labelText: titlee,
                ),
                controller: controllerGroupTitleText,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async{
                  if(this.widget.grupo==null){
                    String title= controllerGroupTitleText.text.trim();
                    if(title.isNotEmpty){
                      Group group =  Group(
                          groupName: controllerGroupTitleText.text,
                          uidOwner: this.widget.uid
                      );
                      this.widget.liGroups.add(
                          group
                      );
                      Database db = Database(this.widget.uid);
                      db.createGroup(group);
                      this.widget.updateState();
                      Navigator.pop(context);
                    }else{
                      final snackBar = SnackBar(
                        content: Text('Ingrese un titulo para el grupo'),
                      );
                      Scaffold.of(context).showSnackBar(snackBar);
                    }
                  }else{
                    String newTitle=controllerGroupTitleText.text.trim();
                    if(newTitle.isNotEmpty){
                      await FirebaseFirestore.instance.collection('Groups').doc(this.widget.grupo.id).update(
                          {'groupName':controllerGroupTitleText.text})
                          .then((value) => print('Grupo actualizado'))
                          .catchError((error) => print('Error: $error'));
                      this.widget.grupo.groupName=controllerGroupTitleText.text;
                    }
                      this.widget.updateState();
                      Navigator.pop(context);
                  }
                },
                child: Text('Next'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xff30475e)), //Color de boton
                ),
              ),
            ),
          ],

        ),
      ),
      backgroundColor: Color(0xff373a40), //color de fondo
    );
  }
}