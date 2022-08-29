// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revember_app/firebase_options.dart';
import 'package:revember_app/screens/initial_screens/login_recovery.dart';
import 'package:revember_app/screens/initial_screens/signup_screen2.dart';
import 'screens/initial_screens/welcome_screen.dart';
import 'screens/initial_screens/login_screen.dart';
import 'screens/initial_screens/signup_screen.dart';
import 'screens/main_screens/home_page.dart';
import 'screens/initial_screens/login_recovery.dart';
import 'screens/main_screens/settings.dart';
import 'screens/calendar_screens/add_testdate.dart';
import 'screens/calendar_screens/calendar_screen.dart';
import 'screens/revision_screens/subject_screen.dart';
import 'screens/revision_screens/create_subject.dart';

import 'dart:io' show Platform;
//Platform allows us to identify the current platform

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(Revember());
}
//runApp executes the widget tree and renders the app to the screen, once the Firebase app is initialized

class Revember extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: false,
      debugShowCheckedModeBanner: false,
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
        SignUpScreen2.id: (context) => SignUpScreen2(),
        LoginRecoveryScreen.id: (context) => LoginRecoveryScreen(),
        HomePage.id: (context) => HomePage(),
        SettingsScreen.id: (context) => SettingsScreen(),
        AddTestDate.id: ((context) => AddTestDate()),
        CalendarScreen.id: (context) => CalendarScreen(),
        SubjectScreen.id: (context) => SubjectScreen(),
        CreateSubjectScreen.id: (context) => CreateSubjectScreen(),
      },
    );
  }
}
