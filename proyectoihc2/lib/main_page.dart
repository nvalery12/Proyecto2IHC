import 'package:flutter/material.dart';
import 'card_reminder_list.dart';
import 'reminder.dart';
import 'package:flutter_picker/flutter_picker.dart';

class MainPage extends StatefulWidget{
  List<Reminder> litems;
  MainPage(this.litems);
  @override
  _MainPageState createState() => _MainPageState();
}


class _MainPageState extends State<MainPage> {
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
        /*_hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _timeController.text = _time;
        _timeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();*/
      });
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
            onPressed: () {
              this.widget.litems.add(Reminder(
                  title: 'Parcial',
                  subTitle: 'IHC 5%'
              ));
              _selectDate(context);
              _selectTime(context);
              setState((){});
            },
            backgroundColor: Color(0xff686d76),
          ),
        )
      ],
    );
  }

}
