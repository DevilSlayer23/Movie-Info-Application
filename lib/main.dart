// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_app/screens/forget_password.dart';
import 'package:movie_app/screens/signin_screen.dart';
import 'package:movie_app/screens/tvshow_sceen.dart';
import 'screens/home_page.dart';
import 'screens/login_screen.dart';
import 'screens/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.cyan,
          ).copyWith(
            secondary: Colors.green.shade300,
          ),

        ),
        // darkTheme: ThemeData(
        //   brightness: Brightness.dark,
        //   /* dark theme settings */
        // ),
        themeMode: ThemeMode.light, 
        title: 'Chalchitra',
        debugShowCheckedModeBanner: false,
        // home: HomePage(),
        initialRoute: FirebaseAuth.instance.currentUser == null ? 'loginScreen' : 'homeScreen',
        routes: <String, WidgetBuilder>{
          'homeScreen': (BuildContext context) => HomePage(),
          'loginScreen': (BuildContext context) => Login(),
          'signinScreen': (BuildContext context) => SignIn(),
          'profileScreen': (BuildContext context) => Profile(),
          'forgetPassScreen': (BuildContext context) => ForgetPassword(),
          'tvScreen': (BuildContext context) => TvShowPage(),
        },
      );
}
