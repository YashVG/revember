// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../main_screens/home_page.dart';
import 'login_recovery.dart';
import 'package:revember_app/services/user_services/user_login.dart';
import 'package:revember_app/constants/user_constants.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String password;
  //late modifier means that the variable is initialized at runtime rather than compile time

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //size is a variable that holds the size of the screen

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.height * 0.02),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Login',
                style: TextStyle(fontSize: 30.0),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  username = value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter your username',
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                child: Text('Login'),
                onPressed: () async {
                  if (await checkPassword(username, password) == true) {
                    Navigator.pushNamed(context, HomePage.id);
                  } else {
                    Navigator.pushNamed(context, LoginRecoveryScreen.id);
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: Text('Forgot Password?'),
                onPressed: () {
                  Navigator.pushNamed(context, LoginRecoveryScreen.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}