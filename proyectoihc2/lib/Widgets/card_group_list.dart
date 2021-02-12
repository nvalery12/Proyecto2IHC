import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:proyectoihc2/Models/groupModel.dart';
import 'package:proyectoihc2/Pages/groups_page.dart';
import 'package:proyectoihc2/main.dart';

import 'card_group.dart';


class CardGroupList extends StatefulWidget {
  List<Group> liGroups = List<Group>();
  String uid;
  final updateState;
  CardGroupList(this.liGroups,this.uid,this.updateState);

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
          return _item(Index);
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
                _delete(index);
                this.widget.liGroups.removeAt(index);
                setState(() {});
              }),
        ],
        leadingActions: [
          SwipeAction(
              title: "Editar",
              color: Colors.green,
              onTap: (handler) async {
                await handler(true);
                if(this.widget.uid==this.widget.liGroups[index].uidOwner){
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>
                        SecondRoute(this.widget.liGroups, this.widget.uid, this.widget.updateState,grupo: this.widget.liGroups[index],)
                    ),
                  );
                }else{
                  final snackBar = SnackBar(
                    content: Text('Solo el dueño del grupo puede modificarlo'),
                  );
                  Scaffold.of(context).showSnackBar(snackBar);
                }
                setState(() {});
              }),
        ],
        child: CardGroup(widget.liGroups[index]),
      );
    }

    void _delete(int index) async {
      if (this.widget.uid == this.widget.liGroups[index].uidOwner) {
        FirebaseFirestore.instance.collection('Groups').doc(
            this.widget.liGroups[index].id).delete();
      } else {
        this.widget.liGroups[index].Members.remove(this.widget.uid);
        await FirebaseFirestore.instance.collection('Groups').doc(
            this.widget.liGroups[index].id).update({
          'arrayMembers': this.widget.liGroups[index].Members,
        })
            .then((value) => print("Members updated."))
            .catchError((error) => print("Failed to update members: $error"));
      }
    }
}