import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyectoihc2/Pages/scanQR_page.dart';

class ConfigurationPage extends StatelessWidget{
  String uid;
  ConfigurationPage(this.uid);

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
        ListTile(
          title: Text('Moon'),
        ),
        ListTile(
          title: Text('Star'),
        ),
      ],
    );
  }
}