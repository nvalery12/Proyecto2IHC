import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyectoihc2/Models/reminder.dart';
import 'package:proyectoihc2/Pages/scanQR_page.dart';
import 'package:proyectoihc2/Services/authServices.dart';
import 'package:provider/provider.dart';

class ConfigurationPage extends StatelessWidget{
  String uid;
  List<Reminder> litems;
  ConfigurationPage(this.uid,this.litems);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      children: [
        Card(
            child:
            ListTile(
              title: Text('Escanear QR'),
              onTap: (){
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ScanQR(uid)
                  ),
                );
              },
            )
        ),
        Card(
            child:
            ListTile(
              title: Text('Cerrar sesion'),
              onTap: () async{
                litems.removeRange(0,litems.length);
                uid = '';
                context.read<AuthenticationService>().signOut();
              },
            )
        ),
      ],
    );
  }
}