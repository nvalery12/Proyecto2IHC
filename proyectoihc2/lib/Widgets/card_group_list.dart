import 'package:flutter/material.dart';
import 'package:proyectoihc2/Models/groupModel.dart';

import 'card_group.dart';


class CardGroupList extends StatelessWidget {
  List<Group> liGroups = List<Group>();
  CardGroupList(this.liGroups);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: liGroups.length,
        itemBuilder: (BuildContext ctxt, int Index) {
          return CardGroup(liGroups[Index]);
        }
    );
  }
  
}