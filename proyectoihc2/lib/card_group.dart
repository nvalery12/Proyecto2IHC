import 'package:flutter/material.dart';

class CardGroup extends StatelessWidget{

  String groupName;
  CardGroup(this.groupName);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RaisedButton(
        onPressed:() {
          print("Si le dio");
        },
        child: Container(
          height: (MediaQuery.of(context).size.height)/7,
          color: Color(0xff686d76),
          child: Row(
              children: <Widget>[
                Container(
                  child: Text(
                      groupName,
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