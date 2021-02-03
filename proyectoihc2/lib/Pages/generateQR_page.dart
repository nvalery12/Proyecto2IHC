import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQR extends StatefulWidget {
  String qrData;
  GenerateQR(this.qrData);
  @override
  _GenerateQRState createState() => _GenerateQRState();
}

class _GenerateQRState extends State<GenerateQR> {

  @override
  Widget build(BuildContext context) {
    print(this.widget.qrData);
    return Scaffold(
      //Appbar having title
      appBar: AppBar(
        title: Center(child: Text("Generate QR Code")),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(

          //Scroll view given to Column
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              QrImage(data: this.widget.qrData),
              SizedBox(height: 20),
              Text("Generate QR Code",style: TextStyle(fontSize: 20),),
            ],
          ),
        ),
      ),
    );
  }
}
