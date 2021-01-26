import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proyectoihc2/database.dart';
import 'package:proyectoihc2/groups_page.dart';
import 'package:proyectoihc2/main_page.dart';
import 'package:proyectoihc2/reminder.dart';
import 'reminder.dart';
import 'package:provider/provider.dart';
import 'authServices.dart';
import 'sing_in_page.dart';

List<Reminder> litems = List<Reminder>();
String uid = "";

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

class AuthenticationWrapper extends StatefulWidget {
  @override
  _AuthenticationWrapperState createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {

  @override
  Widget build(BuildContext context) {
    var firebaseUser = context.watch<User>();
    if (firebaseUser != null) {
      uid = firebaseUser.uid;
      Database db = new Database(uid);
      db.getListPersonalReminder(litems);
      setState(() {});
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
      body: GroupPage(uid), //,MainPage(litems,uid)
      backgroundColor: Color(0xff373a40),
    );
  }
}