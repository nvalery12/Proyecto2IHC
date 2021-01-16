import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proyectoihc2/main_page.dart';
import 'package:proyectoihc2/reminder.dart';
import 'reminder.dart';

List<Reminder> litems = List<Reminder>();

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
        home: MyHomePage(),
        theme: ThemeData(
          primaryColor: Color(0xff30475e),
          accentColor:  Color(0xff30475e),
          cardColor:  Color(0xff30475e)
    ),
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
      backgroundColor: Color(0xff373a40),
    );
  }
}
