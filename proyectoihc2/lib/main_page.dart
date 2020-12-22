import 'package:flutter/material.dart';
import 'card_reminder_list.dart';
import 'reminder.dart';

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
              setState((){});
            },
            backgroundColor: Color(0xff686d76),
          ),
        )
      ],
    );
  }

}
