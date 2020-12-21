import 'package:flutter/material.dart';
import 'reminder.dart';

class CardReminder extends StatelessWidget {
  Reminder reminder;
  CardReminder(this.reminder);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child:Container(
        width: (MediaQuery.of(context).size.width)/1.25,
        height: (MediaQuery.of(context).size.height)/13,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  children: [
                    Text(reminder.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,)),
                    Text(reminder.subTitle, style: TextStyle(fontSize: 13), )
                  ],
                ),
              )
            ),

            Expanded(
              flex: -1,
              child: Container(
                alignment: Alignment.center,
                width: (MediaQuery.of(context).size.width)/8,
                child: Column(
                  children: [
                    Text("-50", style: TextStyle(fontSize: 20)),
                    Text("ASs", style: TextStyle(fontSize: 5))
                  ],
                ),

                )
              )

            ],
          ),
        )
      )
    );
  }
}
