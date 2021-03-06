import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyectoihc2/Models/groupModel.dart';
import 'package:proyectoihc2/Models/reminder.dart';
import 'package:proyectoihc2/Pages/reminders_page.dart';

class MainPageWrapper extends StatelessWidget{
  List<Reminder> litems;
  String uid;
  Group group;

  MainPageWrapper(this.litems,this.uid,[this.group]); //Tiene el parametro opcional group, ya que es una pagina que tambien se utiliza para las paginas de los grupos

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (group != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(group.groupName),
        ),
        body:MainPage(litems,uid,group),
        backgroundColor: Color(0xff373a40),
      );
    }
    return MainPage(litems,uid);
  }}