import 'package:flutter/material.dart';
import 'package:proyectoihc2/BaseDatos.dart';
import 'card_reminder.dart';
import 'reminder.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';


class CardReminderList extends StatefulWidget{
  Basedatos db;
  CardReminderList(this.db);
  @override
  _CardReminderListState createState() => _CardReminderListState();
}

class _CardReminderListState extends State<CardReminderList> {
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return FutureBuilder<List>(
      future: this.widget.db.getReminders(),
      initialData: List(),
      builder: (context, snapshot){
        return snapshot.hasData ?
        ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext ctxt, int Index) {
            return _item(Index,snapshot);
          },
        ) :
        Center(
          child: Text("Ingrese una tarea"),
        );
      },
    );
  }
  Widget _item(int index, AsyncSnapshot<dynamic> snapshot) {
    return SwipeActionCell(
      index: index,
      key: ValueKey(snapshot.data[index]),
      performsFirstActionWithFullSwipe: true,
      trailingActions: [ //Opciones de derecha a izquierda
        SwipeAction(
            icon: Icon(
              Icons.watch_later
            ),
            nestedAction: SwipeNestedAction(title: "Confirmar"),
            onTap: (handler) async {
              await handler(true);
              this.widget.db.delete(snapshot.data[index].id); // Snapshot.data = List<Reminder>
              snapshot.data.removeAt(index);
              setState(() {});
            }),
      ],
      leadingActions: [ //Opciones de izquierda a derecha
        SwipeAction(
            title: "Completar",
            color: Colors.green,
            onTap: (handler) async {
              await handler(true);
              this.widget.db.delete(snapshot.data[index].id);
              setState(() {});
            }),
      ],
      child: CardReminder(snapshot.data[index]),
    );
  }
}