import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proyectoihc2/BaseDatos.dart';
import 'package:proyectoihc2/main_page.dart';
import 'package:proyectoihc2/reminder.dart';
import 'reminder.dart';
import 'dart:async';

List<Reminder> litems = [];

void main() async{
  Basedatos db;
  db.initDB();
  Reminder a= Reminder(title: "Calculo",subTitle: "Tema 1", id: -1);
  Reminder b= Reminder(title: "Program",subTitle: "Tema 1", id: -1);
  db.insert(a);
  db.insert(b);
  List<Reminder> list= await db.getReminders();
  list.forEach((element) {print(element.title);});


  //runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
        title: 'FiTime',
        home: MyHomePage()
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: MainPage(litems),
     /* floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          litems.add(Reminder(
            title: 'Parcial',
            subTitle: 'IHC 5%'
          ));
          print("Si se metio");
          setState((){});
        },
      ),*/
      backgroundColor: Color(0xff373a40),
    );
  }
}
