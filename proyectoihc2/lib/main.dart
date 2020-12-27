import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proyectoihc2/BaseDatos.dart';
import 'package:proyectoihc2/reminder.dart';
import 'card_reminder_list.dart';
import 'reminder.dart';



void main() {
  runApp(MyApp());
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
  Basedatos db= Basedatos();
  List<Reminder> litems = [];

  @override
  void initState(){
    db.initDB();
    super.initState();
  }

  Future<List<Reminder>> loadList() async{
    return await db.getReminders();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: //CardReminderList(litems),
      Text("Hola"),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          db.insert(
            Reminder(
              title: "Titulo",
              subTitle: "Subtitulo",
              isFinish: false,
              id: -1,
            )
          );
          print("Si se metio");
          setState((){});
        },
      ),
    );
  }
}
