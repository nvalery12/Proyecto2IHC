import 'package:flutter/cupertino.dart';
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

  Future<int> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime(DateTime
            .now()
            .year, DateTime
            .now()
            .month, DateTime
            .now()
            .day),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101)
    );
    if (picked != null) {
      var dateTimeNow = DateTime( DateTime.now().year, DateTime.now().month,DateTime.now().day);
      if (picked.isBefore(dateTimeNow)) {
        final snackBar = SnackBar(
          content: Text('Ingrese una fecha posterior a la actual'),
        );
        Scaffold.of(context).showSnackBar(snackBar);
        return 0;
      } else if (picked.isAfter(dateTimeNow)) {
        setState(() {
          selectedDate = picked;
        });
        return 1;
      }else if(picked.isAtSameMomentAs(dateTimeNow)){
        setState(() {
          selectedDate = picked;
        });
        return 2;
      }
    }
  }

  Future<bool> _selectTime(BuildContext context, int selectedTimeOp) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      var dateTimeNow = DateTime( 0, 0, 0,DateTime.now().hour,DateTime.now().minute);
      var timeDay = DateTime( 0, 0, 0,picked.hour,picked.minute);
      if((selectedTimeOp == 2) & (timeDay.isBefore(dateTimeNow))){
        final snackBar = SnackBar(
          content: Text('Ingrese una fecha posterior a la actual'),
        );
        Scaffold.of(context).showSnackBar(snackBar);
        return false;
      }else{
        setState(() {
          selectedTime = picked;
        });
        return true;
      }

    }

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
    await flutterLocalNotificationsPlugin.schedule(
        3,
        reminder.title,
        '¡Ya empezo!',
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
      body: Builder(
        builder: (BuildContext context) {
          return Container(
            child:  Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0, top: 40.0),
                  child: TextField(
                    maxLength: 17,
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
                      labelText: 'Titulo',
                    ),
                    controller: controllerTitleText,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    maxLength: 20,
                    maxLengthEnforced: true,
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
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async{
                      int selectedDateOp;
                      bool selectedTimeOp;
                      selectedDateOp= await _selectDate(context);
                      if(selectedDateOp>0){
                        selectedTimeOp = await _selectTime(context,selectedDateOp);
                        if(selectedTimeOp){
                          Reminder reminder;
                          String title= controllerTitleText.text.trim();
                          if(title.isNotEmpty){
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
                          }else{
                            final snackBar = SnackBar(
                              content: Text('Ingrese un titulo para el recordatorio'),
                            );
                            Scaffold.of(context).showSnackBar(snackBar);
                          }
                        }
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
          );
        },
      ),
      backgroundColor: Color(0xff373a40), //color de fondo
    );
  }
}
