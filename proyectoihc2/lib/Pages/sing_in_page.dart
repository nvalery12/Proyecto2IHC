
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectoihc2/Pages/register_page.dart';
import 'package:proyectoihc2/Services/authServices.dart';

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
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0, top: 35.0),
            child: TextField(
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
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 20.0, top: 8.0),
            child: TextField(
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
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,  //alineamiento
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  onPressed: () {
                    context.read<AuthenticationService>().signIn(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                    );
                  },
                  child: Text("Ingresar"),
                  color: Color(0xff30475e), //Color de boton
                  textColor: Colors.white,  //Color de letra
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RegisterPage(),
                      ),
                    );
                  },
                  child: Text("Registrarse"),
                  color: Color(0xff30475e),
                  textColor: Colors.white,
                ),
              ),
            ],
          )
        ],
      ),
      backgroundColor: Color(0xff373a40), //color de fondo
    );
  }
}