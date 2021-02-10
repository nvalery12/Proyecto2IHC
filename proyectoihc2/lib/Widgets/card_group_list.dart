import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:proyectoihc2/Models/groupModel.dart';
import 'package:proyectoihc2/main.dart';

import 'card_group.dart';


class CardGroupList extends StatefulWidget {
  List<Group> liGroups = List<Group>();
  String uid;
  CardGroupList(this.liGroups,this.uid);

  @override
  _CardGroupListState createState() => _CardGroupListState();
}

class _CardGroupListState extends State<CardGroupList> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: widget.liGroups.length,
        itemBuilder: (BuildContext ctxt, int Index) {
          if (this.widget.liGroups[Index].uidOwner == this.widget.uid) {
            return _item(Index);
          } else {
            return CardGroup(widget.liGroups[Index]);
          }
        }
    );
  }

        Widget _item(int index) {
      return SwipeActionCell(
        index: index,
        key: ValueKey(this.widget.liGroups[index]),
        performsFirstActionWithFullSwipe: true,
        trailingActions: [ //Opciones de derecha a izquierda
          SwipeAction(
              icon: Icon(
                  Icons.delete
              ),
              nestedAction: SwipeNestedAction(title: "Confirmar"),
              onTap: (handler) async {
                await handler(true);
                /*FirebaseFirestore.instance.collection('Users')
                    .doc(widget.uid)
                    .collection('Personal Reminder')
                    .doc(widget.litems[index].id)
                    .delete();*/
                this.widget.liGroups.removeAt(index);
                setState(() {});
              }),
        ],
        child: CardGroup(widget.liGroups[index]),
      );
    }
}