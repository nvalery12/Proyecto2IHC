import 'package:flutter/material.dart';
import 'card_reminder_list.dart';
import 'reminder.dart';
import 'authServices.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget{
  List<Reminder> litems;
  MainPage(this.litems);
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
        CardReminderList(this.widget.litems),
        Align(
          alignment: Alignment.bottomRight,
          child: new FloatingActionButton(
            child: new Icon(Icons.add),
            heroTag: "btn2",
            onPressed: (){
              Reminder reminder;
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => SecondRoute(this.widget.litems,updateState)
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
  List<Reminder> litems;
  SecondRoute(this.litems, this.updateState);
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
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Titulo',
              ),
              controller: controllerTitleText,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Descripción',
              ),
              controller: controllerSubTitleText,
            ),
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
                this.widget.updateState();
                Navigator.pop(context);
              },
              child: Text('Go back!'),
            ),
          ],

        ),
      ),
    );
  }
}

