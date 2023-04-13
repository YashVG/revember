// ignore_for_file: prefer_const_constructors, no_logic_in_create_state, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';

import 'package:revember_app/preferences/themes.dart';
import 'package:revember_app/screens/settings_screens/change_password.dart';
import 'package:revember_app/screens/settings_screens/erase_data_screen.dart';
import 'package:revember_app/screens/settings_screens/nuke_account.dart';

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
    if (Platform.isMacOS || Platform.isWindows) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 90,
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
                onPressed: () {
                  isDark = false;
                },
                child: Text('Change app theme'),
              ),
              SizedBox(
                height: 35,
              ),
              ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.white70),
                onPressed: () {
                  Navigator.pushNamed(context, EraseDataScreen.id);
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
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.white70),
                onPressed: () {
                  Navigator.pushNamed(context, NukeAccount.id);
                },
                child: Text(
                  'Delete account',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 90,
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
                onPressed: () {
                  isDark = false;
                },
                child: Text('Change app theme'),
              ),
              SizedBox(
                height: 35,
              ),
            ],
          ),
        ),
      );
    }
  }
}
