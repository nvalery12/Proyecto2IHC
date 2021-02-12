import 'package:flutter/material.dart';
import 'package:proyectoihc2/Models/groupModel.dart';
import 'package:proyectoihc2/Models/reminder.dart';
import 'card_reminder.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyectoihc2/Pages/inputReminderData.dart';

class CardReminderList extends StatefulWidget{
  List<Reminder> litems;
  String uid;
  Group grupo;
  bool isOwner;
  final updateState;
  CardReminderList(this.litems,this.uid,this.isOwner,this.updateState,{this.grupo});
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
        if(this.widget.isOwner){
          return _item(Index);
        }else{
          return CardReminder(this.widget.litems[Index]);
        }
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
                Icons.delete
            ),
            nestedAction: SwipeNestedAction(title: "Confirmar"),
            onTap: (handler) async {
              await handler(true);
              if(this.widget.grupo!=null){
              FirebaseFirestore.instance.collection('Users')
                  .doc(widget.uid)
                  .collection('Personal Reminder')
                  .doc(widget.litems[index].id)
                  .delete();
              this.widget.litems.removeAt(index);
              setState(() {});
            }else{
                FirebaseFirestore.instance.collection('Groups').doc(this.widget.grupo.id)
                    .collection('Reminders').doc(this.widget.litems[index].id).delete();
              }
            }),
      ],
      leadingActions: [ //Opciones de izquierda a derecha
        SwipeAction(
            title: "Editar",
            color: Colors.green,
            onTap: (handler) async {
              await handler(true);
              if(this.widget.grupo==null){
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>
                      InputReminderData(this.widget.litems, this.widget.uid, this.widget.updateState,recordatorio: this.widget.litems[index])),
                );
              }else{
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>
                      InputReminderData(this.widget.litems, this.widget.uid, this.widget.updateState,recordatorio: this.widget.litems[index],group: this.widget.grupo,)),
                );
              }
              setState(() {});
            }),
      ],
      child: CardReminder(this.widget.litems[index]),
    );
  }
}