import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyectoihc2/database.dart';
import 'card_reminder_list.dart';
import 'reminder.dart';
import 'authServices.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget{
  List<Reminder> litems;
  String uid;
  MainPage(this.litems,this.uid);
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  void updateState(){
    setState((){});
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        CardReminderList(this.widget.litems,this.widget.uid),
        Align(
          alignment: Alignment.bottomRight,
          child: new FloatingActionButton(
            child: new Icon(Icons.add),
            heroTag: "btn2",
            onPressed: (){
              Reminder reminder;
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => SecondRoute(this.widget.litems,this.widget.uid,updateState)
                  ),
              );
              setState((){});
            },
            backgroundColor: Color(0xff686d76),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: new FloatingActionButton(
            child: new Icon(Icons.email),
            heroTag: "btn1",
            onPressed: (){
              context.read<AuthenticationService>().signOut();
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
  String uid;
  List<Reminder> litems;
  SecondRoute(this.litems,this.uid, this.updateState);
  @override
  _SecondRouteState createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {
  DateTime selectedDate;
  TimeOfDay selectedTime;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101)
    );
    if (picked != null)
      setState(() {
        selectedDate = picked;
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
      });
  }

  final controllerTitleText = TextEditingController();
  final controllerSubTitleText = TextEditingController();
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
              cursorColor: Colors.white,            //Color del cursor
              style: TextStyle(color: Colors.white),//Color de texto
              decoration: InputDecoration(
                fillColor: Color(0xff686d76),       //Color de relleno
                filled: true,                       //Relleno activado
                border: OutlineInputBorder(),
                labelText: 'Titulo',
              ),
              controller: controllerTitleText,
            ),
            SizedBox(height: MediaQuery.of(context).size.height/50,), //Espacio entre widgets
            TextField(
              cursorColor: Colors.white,            //Color del cursor
              style: TextStyle(color: Colors.white),//Color de texto
              decoration: InputDecoration(
                fillColor: Color(0xff686d76),       //Color de relleno
                filled: true,                       //Relleno activado
                border: OutlineInputBorder(),
                labelText: 'Descripción',
              ),
              controller: controllerSubTitleText,
            ),
            SizedBox(height: MediaQuery.of(context).size.height/10,), //Espacio entre segundo widget y boton
            ElevatedButton(
              onPressed: () async{
                await _selectDate(context);
                await _selectTime(context);
                Reminder reminder;
                reminder = Reminder(
                  title: controllerTitleText.text,
                  subTitle: controllerSubTitleText.text,
                );
                reminder.updateDeadline(selectedDate, selectedTime);
                this.widget.litems.add(
                  reminder
                );
                //setState(() {});
                Database user = Database(this.widget.uid,reminder);
                user.addReminder();
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

