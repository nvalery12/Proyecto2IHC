import 'package:flutter/material.dart';
import 'package:proyectoihc2/database.dart';
import 'card_reminder_list.dart';
import 'groupModel.dart';
import 'inputReminderData.dart';
import 'reminder.dart';
import 'authServices.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget{
  List<Reminder> litems;
  String uid;
  Group group;
  MainPage(this.litems,this.uid,[this.group]);
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  void updateState(){
    setState((){});
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        CardReminderList(this.widget.litems,this.widget.uid),
        Align(
          alignment: Alignment.bottomRight,
          child: new FloatingActionButton(
            child: new Icon(Icons.add),
            heroTag: "btn2",
            onPressed: (){
              if (this.widget.group == null) {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => InputReminderData(this.widget.litems,this.widget.uid,updateState)
                  ),
                );
              }
              if (this.widget.group != null) {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => InputReminderData(this.widget.litems,this.widget.uid,updateState,this.widget.group)
                  ),
                );
              }
              setState(() {});
            },
            backgroundColor: Color(0xff686d76),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: new FloatingActionButton(
            child: new Icon(Icons.email),
            heroTag: "btn1",
            onPressed: (){
              this.widget.litems.removeRange(0,this.widget.litems.length);
              context.read<AuthenticationService>().signOut();
            },
            backgroundColor: Color(0xff686d76),
          ),
        ),
      ],
    );
  }
}


