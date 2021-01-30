import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:proyectoihc2/Services/dynamicLinks.dart';
import 'package:proyectoihc2/pages/groups_page.dart';
import 'package:proyectoihc2/pages/reminders_page.dart';
import 'package:proyectoihc2/pages/sing_in_page.dart';
import 'Models/reminder.dart';
import 'Services/authServices.dart';
import 'Services/database.dart';

List<Reminder> litems = List<Reminder>();
String uid = "";
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {});
  var initializationSettings = InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
        if (payload != null) {
          debugPrint('notification payload: ' + payload);
        }
      });
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
          title: 'Finals Countdown',
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
  void updateState(){
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    var firebaseUser=context.watch<User>();

    if (firebaseUser != null) {
      uid = firebaseUser.uid;
      print("En authWrapper " + litems.length.toString());
      setState((){});
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
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    MainPage(litems, uid),
    GroupPage(uid)
    ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DynamicLinksService dynamicLink = DynamicLinksService();
    dynamicLink.fetchLinkData();
    print("En init state: " + litems.length.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  _widgetOptions.elementAt(_selectedIndex),
      backgroundColor: Color(0xff373a40),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}