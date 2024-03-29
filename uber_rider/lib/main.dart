import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber/AllScreens/loginscreen.dart';
import 'package:uber/AllScreens/mainscreen.dart';
import 'package:uber/AllScreens/registrationscreen.dart';
import 'package:uber/AllScreens/search.dart';
import 'package:uber/Datahandaler/appData.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

DatabaseReference usersRef =
    FirebaseDatabase.instance.reference().child("users");

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: MaterialApp(
        title: 'Taxi Rider App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // initialRoute: MainScreen.idScreen,
        initialRoute: FirebaseAuth.instance.currentUser == null
            ? LoginScreen.idScreen
            : MainScreen.idScreen,
        routes: {
          // '/search': (context) => SearchScreen(),
          RegistrationScreen.idScreen: (context) => RegistrationScreen(),
          LoginScreen.idScreen: (context) => LoginScreen(),
          MainScreen.idScreen: (context) => MainScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
