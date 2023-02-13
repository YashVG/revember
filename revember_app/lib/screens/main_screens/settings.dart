// ignore_for_file: prefer_const_constructors, no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:revember_app/components/back_button.dart';
import 'package:revember_app/preferences/themes.dart';
import 'package:revember_app/screens/settings_screens/change_password.dart';
import 'dart:io' show Platform;

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
      floatingActionButton: GoBackButton(),
      body: Center(
        child: Column(
          children: [
            (Platform.isIOS || Platform.isAndroid)
                ? SizedBox(height: 40)
                : SizedBox(height: 0),
            SizedBox(height: 40),
            Text(
              'Settings',
              style: TextStyle(fontSize: 30.0),
            ),
            SizedBox(
              height: 60,
            ),
            ElevatedButton(
              onPressed: () {
                isDark = isDark == true ? false : true;
              },
              child: Text('Change light/dark mode'),
            ),
            SizedBox(
              height: 35,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, ChangePasswordScreen.id);
              },
              child: Text('Change password for account'),
            ),
            SizedBox(
              height: 15,
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
              onPressed: () {},
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
