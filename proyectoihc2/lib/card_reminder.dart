import 'package:flutter/material.dart';
import 'reminder.dart';

class CardReminder extends StatelessWidget {
  Reminder reminder;
  CardReminder(this.reminder);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        height: (MediaQuery.of(context).size.height)/7,
        color: Color(0xff686d76),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Text(reminder.title,
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            )
                        ),
                      Text(reminder.subTitle,
                            style: TextStyle(
                              fontSize: 20,
                            )
                        ),
                    ],
                  ),
                ),
              )
            ),
            Expanded(
              flex: -1,
              child: Container(
                color: Color(0xff30475e),
                alignment: Alignment.center,
                width: (MediaQuery.of(context).size.width)/4,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Text(reminder.remainigTime(),
                          style: TextStyle(
                              fontSize: 35
                          )
                      ),
                      Text(reminder.deadLineDate(),
                          style:
                          TextStyle(
                              fontSize: 15
                          )
                      )
                    ],
                  ),
                ),
                )
              )
            ],
          ),
        );
  }
}
