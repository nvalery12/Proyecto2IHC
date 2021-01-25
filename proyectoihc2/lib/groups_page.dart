import 'package:flutter/material.dart';

class GroupPage extends StatefulWidget{

  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {

  void updateState(){
    setState((){});
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        //CardReminderList(this.widget.litems,this.widget.uid), //CardGroupList
        Align(
          alignment: Alignment.bottomRight,
          child: new FloatingActionButton(
            child: new Icon(Icons.add),
            onPressed:(){},
            backgroundColor: Color(0xff686d76),
          ),
        ),
      ],
    );
  }
}