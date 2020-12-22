import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proyectoihc2/calendar_page.dart';
import 'package:proyectoihc2/reminder.dart';
import 'package:table_calendar/table_calendar.dart';
import 'card_reminder_list.dart';
import 'reminder.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'calendar.dart';

List<Reminder> litems = [];

void main() {
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
        title: 'Calendario',
        home: MyHomePage()
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CalendarController calendarController;


  @override
  void  initState () {
    super.initState();
    calendarController =  CalendarController ();
  }

  @override
  void dispose() {
    calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      /*body: CardReminderList(litems),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          litems.add(Reminder(
            title: 'Titulo',
            subTitle: 'subTitulo'
          ));
          print("Si se metio");
          setState((){});
        },
      ),*/

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TableCalendar(
              onDaySelected: (date, events, _){
                print(date.toIso8601String());
              },
              calendarController: calendarController,
            ),
            Text(""),
            Text("Martes, 22 de Diciembre 2020",
            ),
          ],
        ),
      ),
    );
  }
}
