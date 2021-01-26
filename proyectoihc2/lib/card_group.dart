import 'package:flutter/material.dart';
import 'package:proyectoihc2/groupModel.dart';
import 'package:proyectoihc2/main_page.dart';

class CardGroup extends StatelessWidget{

  Group group;
  CardGroup(this.group);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RaisedButton(
        onPressed:() {
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => MainPage(this.group.reminderList,group.id,this.group)),
          );
          print("Si le dio");
        },
        child: Container(
          height: (MediaQuery.of(context).size.height)/7,
          color: Color(0xff686d76),
          child: Row(
              children: <Widget>[
                Container(
                  child: Text(
                      group.groupName,
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                      )
                  ),
                )
              ]
          ),
        )
    );
  }

}