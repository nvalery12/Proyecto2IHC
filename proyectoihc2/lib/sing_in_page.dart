import 'authServices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'database.dart';

class SignInPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inicio de Sesion"),
      ),
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height/10,), //Espacio top y primer widget
          TextField(
            cursorColor: Colors.white,            //Color del cursor
            controller: emailController,
            style: TextStyle(color: Colors.white),//Color de texto
            decoration: InputDecoration(
              border: new OutlineInputBorder(     //Bordes redondos
                borderRadius: const BorderRadius.all(
                  const Radius.circular(25.0),
                ),
              ),
              fillColor: Color(0xff686d76),       //Color de relleno
              filled: true,                       //Relleno activado
              labelText: "Email",
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height/50,), //Espacio entre widgets
          TextField(
            obscureText: true,                      //Contrasenia no visible
            cursorColor: Colors.white,          //color del cursor
            controller: passwordController,
            style: TextStyle(color: Colors.white),//Color de texto
            decoration: InputDecoration(
              border: new OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(25.0),
                ),
              ),
              fillColor: Color(0xff686d76),       //Color de relleno
              filled: true,                       //Relleno activado
              labelText: "Password",
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height/10,), //Espacio entre segundo widget y botones
          Row(
            mainAxisAlignment: MainAxisAlignment.center,  //alineamiento
            children: [
              RaisedButton(
                onPressed: () {
                  context.read<AuthenticationService>().signIn(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  );
                },
                child: Text("Sign in"),
                color: Color(0xff30475e), //Color de boton
                textColor: Colors.white,  //Color de letra
              ),
              SizedBox(width: MediaQuery.of(context).size.width/10,), //Espacio entre botones
              RaisedButton(
                onPressed: () {
                  context.read<AuthenticationService>().signUp(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  );
                },
                child: Text("Sign up"),
                color: Color(0xff30475e),
                textColor: Colors.white,
              ),
            ],
          )
        ],
      ),
      backgroundColor: Color(0xff373a40), //color de fondo
    );
  }
}