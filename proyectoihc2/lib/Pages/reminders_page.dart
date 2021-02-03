
import 'package:flutter/material.dart';
import 'package:proyectoihc2/Models/groupModel.dart';
import 'package:proyectoihc2/Models/reminder.dart';
import 'package:proyectoihc2/Pages/generateQR_page.dart';
import 'package:proyectoihc2/Services/authServices.dart';
import 'package:proyectoihc2/Services/database.dart';
import 'package:proyectoihc2/Widgets/card_reminder_list.dart';
import 'package:proyectoihc2/main.dart';
import 'inputReminderData.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget{
  List<Reminder> litems;
  String uid;
  Group group;
  MainPage(this.litems,this.uid,[this.group]); //Tiene el parametro opcional group, ya que es una pagina que tambien se utiliza para las paginas de los grupos
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  
  void updateState(){
    setState((){});
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Database db = new Database(uid);
    db.getListPersonalReminder(litems,updateState);
    if(this.widget.group != null){
      db.getListGroupReminder(this.widget.group.reminderList,this.widget.group.id,updateState);
    }
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
                  MaterialPageRoute(builder: (context) => InputReminderData(this.widget.litems, this.widget.uid, updateState)
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
            onPressed:() async {
              if (this.widget.group == null) {
                this.widget.litems.removeRange(0,this.widget.litems.length);
                this.widget.uid = '';
                this.widget.group = null;
                context.read<AuthenticationService>().signOut();
              }
              if (this.widget.group != null) {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => GenerateQR(this.widget.group.id)
                  ),
                );
              }
            },
            backgroundColor: Color(0xff686d76),
          ),
        ),
      ],
    );
  }
}


