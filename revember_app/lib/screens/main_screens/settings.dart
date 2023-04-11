// ignore_for_file: prefer_const_constructors, no_logic_in_create_state, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:revember_app/constants/user_constants.dart';

import 'package:revember_app/preferences/themes.dart';
import 'package:revember_app/screens/initial_screens/welcome_screen.dart';
import 'package:revember_app/screens/settings_screens/change_password.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  static const String id = 'settings_page';
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState([true, false]);
}

class _SettingsScreenState extends State<SettingsScreen> {
  final List<bool> isSelected;

  _SettingsScreenState(this.isSelected);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            ElevatedButton(
              onPressed: () {
                isDark = isDark == true ? false : true;
                setState(() {});
              },
              child: Text('Change light/dark mode'),
            ),
            SizedBox(
              height: 35,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, ChangePassword.id);
              },
              child: Text('Change password for account'),
            ),
            SizedBox(
              height: 35,
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Change app theme'),
            ),
            SizedBox(
              height: 35,
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Reset app settings'),
            ),
            SizedBox(
              height: 35,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white70),
              onPressed: () async {
                final SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                sharedPreferences.remove('username');
                sharedPreferences.remove('password');
                sharedPreferences.setBool('isLoggedIn', false);
                user = '';
                Navigator.pushNamed(context, WelcomeScreen.id);
              },
              child: Text(
                'Erase all data',
                style: TextStyle(color: Colors.red),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white70),
              onPressed: () {},
              child: Text(
                'Delete account',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
