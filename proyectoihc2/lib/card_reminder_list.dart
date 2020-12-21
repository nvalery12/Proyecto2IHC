import 'package:flutter/material.dart';
import 'card_reminder.dart';
import 'reminder.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';


class CardReminderList extends StatefulWidget{
  List<Reminder> litems;
  CardReminderList(this.litems);
  @override
  _CardReminderListState createState() => _CardReminderListState();
}

class _CardReminderListState extends State<CardReminderList> {
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: this.widget.litems.length,
      itemBuilder: (BuildContext ctxt, int Index) {
        return _item(Index);
      },
    );
  }
  Widget _item(int index) {
    return SwipeActionCell(
      index: index,
      key: ValueKey(this.widget.litems[index]),
      performsFirstActionWithFullSwipe: true,
      trailingActions: [ //Opciones de derecha a izquierda
        SwipeAction(
            icon: Icon(
              Icons.watch_later
            ),
            nestedAction: SwipeNestedAction(title: "Confirmar"),
            onTap: (handler) async {
              await handler(true);
              this.widget.litems.removeAt(index);
              setState(() {});
            }),
      ],
      leadingActions: [ //Opciones de izquierda a derecha
        SwipeAction(
            title: "Completar",
            color: Colors.green,
            onTap: (handler) async {
              await handler(true);
              this.widget.litems.removeAt(index);
              setState(() {});
            }),
      ],
      child: CardReminder(this.widget.litems[index]),
    );
  }
}