import 'package:flutter/material.dart';
import 'package:proyectoihc2/card_group_list.dart';
import 'package:proyectoihc2/database.dart';
import 'package:proyectoihc2/groupModel.dart';

import 'inputReminderData.dart';

class GroupPage extends StatefulWidget{
  String uid;
  List<Group> liGroups = List<Group>();
  GroupPage(this.uid);
  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {

  void updateState(){
    setState((){});
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        CardGroupList(this.widget.liGroups), //CardGroupList
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

  SecondRoute(this.liGroups,this.uid,this.updateState);
  @override
  _SecondRouteState createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {

  final controllerGroupTitleText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Container(
        child:  Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height/10,), //Espacio top y primer widget
            TextField(
              //maxLength: 12,
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
                labelText: 'Titulo',
              ),
              controller: controllerGroupTitleText,
            ),
            SizedBox(height: MediaQuery.of(context).size.height/50,), //Espacio entre widgets
            ElevatedButton(
              onPressed: () async{
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
              },
              child: Text('Next'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xff30475e)), //Color de boton
              ),
            ),
          ],

        ),
      ),
      backgroundColor: Color(0xff373a40), //color de fondo
    );
  }
}