import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proyectoihc2/main_page.dart';
import 'package:proyectoihc2/reminder.dart';
import 'reminder.dart';
import 'package:provider/provider.dart';
import 'authServices.dart';
import 'sing_in_page.dart';

List<Reminder> litems = List<Reminder>();
String uid;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MultiProvider(
        providers: [
          Provider<AuthenticationService>(
            create: (_) => AuthenticationService(FirebaseAuth.instance),
          ),
          StreamProvider(
            create: (context) => context.read<AuthenticationService>().authStateChanges,
    )
    ],
      child: MaterialApp(
          title: 'FiTime',
          home: AuthenticationWrapper(),
          theme: ThemeData(
            primaryColor: Color(0xff30475e),
            accentColor:  Color(0xff30475e),
            cardColor:  Color(0xff30475e)
      ),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      uid = firebaseUser.uid;
      getList();
      return MyHomePage();
    }
    return SignInPage();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainPage(litems,uid),
      backgroundColor: Color(0xff373a40),
    );
  }
}

void getList(){
  List<Reminder> lista = List<Reminder>();
  var auth = uid;
  print(auth);
  FirebaseFirestore.instance.collection('users')
      .doc(auth)
      .collection('RecordatoriosPersonales') //RecordatoriosPersonales
      .get()
      .then((QuerySnapshot querySnapshot) => {
    querySnapshot.docs.forEach((doc) {
      String titulo,subtitulo;
      Timestamp aux;
      DateTime date;
      titulo = doc.data()["Titulo"];
      subtitulo = doc.data()["subTitulo"];
      aux = doc.data()["Date"];
      date = aux.toDate();
      TimeOfDay time = TimeOfDay(hour: date.hour, minute: date.minute);
      var reminder = new Reminder(
        title: titulo,
        subTitle: subtitulo
      );
      reminder.updateDeadline(date, time);
      reminder.id=doc.id;
      litems.add(reminder);
      print("Este es el titulo: " + titulo + " Este es el subTitulo: " + subtitulo);
      print("Esta es la fecha: " + date.toString());
    })
  });
}
