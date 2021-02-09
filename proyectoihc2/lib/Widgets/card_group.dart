import 'package:flutter/material.dart';
import 'package:proyectoihc2/Models/groupModel.dart';
import 'package:proyectoihc2/Pages/reminders_page_wrapper.dart';

class CardGroup extends StatelessWidget{

  Group group;
  CardGroup(this.group);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RaisedButton(
        onPressed:() {
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => MainPageWrapper(this.group.reminderList,group.id,this.group)),
          );
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