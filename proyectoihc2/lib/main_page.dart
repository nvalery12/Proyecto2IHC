import 'package:flutter/material.dart';
import 'card_reminder_list.dart';
import 'reminder.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';

class MainPage extends StatefulWidget{
  List<Reminder> litems;
  MainPage(this.litems);
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
              var date = DateTime.now();
              showMaterialDatePicker(
                context: context,
                selectedDate: date,
                onChanged: (value) => setState(() => date = value),
              );
              var time = TimeOfDay.now();
              showMaterialTimePicker(
                context: context,
                selectedTime: time,
                onChanged: (value) => setState(() => time = value),
              );
              setState((){});
            },
            backgroundColor: Color(0xff686d76),
          ),
        )
      ],
    );
  }

}
