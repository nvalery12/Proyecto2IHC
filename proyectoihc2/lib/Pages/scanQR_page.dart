import 'package:barcode_scan_fix/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:proyectoihc2/Models/groupModel.dart';
import 'package:proyectoihc2/Services/database.dart';

class ScanQR extends StatefulWidget {
  String uid;
  ScanQR(this.uid);
  @override
  _ScanQRState createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQR> {

  String qrCodeResult = "No se ha escaneado nada aun";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Escanea tu codigo QR"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              qrCodeResult,
              style: TextStyle(
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.0,
            ),

            //Button to scan QR code
            FlatButton(
              padding: EdgeInsets.all(15),
              onPressed: () async {
                String codeSanner = await BarcodeScanner.scan(); //barcode scnner
                Database db = Database(this.widget.uid);
                Group group = await db.getUIDGroup(codeSanner);
                setState(() {
                  qrCodeResult = 'Has ingresado exitosamente al grupo: ' + group.groupName;
                });
                db.addGroupMemberWithUID(codeSanner);
              },
              child: Text("Abrir escaner",style: TextStyle(color: Colors.indigo[900]),),
              //Button having rounded rectangle border
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.indigo[900]),
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
