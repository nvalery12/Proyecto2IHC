import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:proyectoihc2/Models/reminder.dart';
import 'package:proyectoihc2/Services/database.dart';
import 'package:proyectoihc2/Models/groupModel.dart';

import '../main.dart';


class InputReminderData extends StatefulWidget {
  final updateState;
  String uid;
  List<Reminder> litems;
  Group group;
  InputReminderData(this.litems,this.uid, this.updateState,[this.group]);
  @override
  _InputReminderData createState() => _InputReminderData();
}

class _InputReminderData extends State<InputReminderData> {
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

  void scheduleAlarm(Reminder reminder) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      'Channel for Alarm notification',
      icon: '@mipmap/ic_launcher',
      //sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
      largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
        //sound: 'a_long_cold_sting.wav',
        presentAlert: true,
        presentBadge: true,
        presentSound: true);
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.schedule(
        0, //Tienen numeros distintos para que no se super ponga una con otra, es decir, que se muestren las dos, no solo una de ellas
        reminder.title,
        'Queda 1 dia para tu evento',
        reminder.deadLine.subtract(Duration(days: 1)),
        platformChannelSpecifics
    );
    await flutterLocalNotificationsPlugin.schedule(
        1,
        reminder.title,
        'Queda 1 hora para tu evento',
        reminder.deadLine.subtract(Duration(hours: 1)),
        platformChannelSpecifics
    );
    await flutterLocalNotificationsPlugin.schedule(
        2,
        reminder.title,
        'Queda 10 minutos para tu evento',
        reminder.deadLine.subtract(Duration(minutes: 10)),
        platformChannelSpecifics
    );
  }


  final controllerTitleText = TextEditingController();
  final controllerSubTitleText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
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
              controller: controllerTitleText,
            ),
            SizedBox(height: MediaQuery.of(context).size.height/50,), //Espacio entre widgets
            TextField(
              //maxLength: 20,
              cursorColor: Colors.white,            //Color del cursor
              style: TextStyle(color: Colors.white),//Color de texto
              decoration: InputDecoration(
                border: new OutlineInputBorder(     //Bordes redondos
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(25.0),
                  ),
                ),
                fillColor: Color(0xff686d76),       //Color de relleno
                filled: true,                       //Relleno activado
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
                Database db = Database(this.widget.uid);
                if (this.widget.group == null) {
                  db.addPersonalReminder(reminder);
                }
                if (this.widget.group != null) {
                  db.addGroupReminder(reminder, this.widget.group);
                }
                scheduleAlarm(reminder);
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
