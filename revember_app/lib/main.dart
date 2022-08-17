// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:revember_app/screens/login_recovery.dart';
import 'package:revember_app/screens/signup_screen2.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_page.dart';
import 'screens/login_recovery.dart';

import 'dart:io' show Platform;
//Platform allows us to identify the current platform

void main() => runApp(Revember());
//runApp executes the widget tree and renders the app to the screen

class Revember extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
        SignUpScreen2.id: (context) => SignUpScreen2(),
        LoginRecoveryScreen.id: (context) => LoginRecoveryScreen(),
        HomePage.id: (context) => HomePage(),
      },
    );
  }
}
