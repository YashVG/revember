// ignore_for_file: prefer_const_constructors, no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:revember_app/components/back_button.dart';

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
    // Color getColor(Set<MaterialState> states) {
    //   const Set<MaterialState> interactiveStates = <MaterialState>{
    //     MaterialState.pressed,
    //     MaterialState.hovered,
    //     MaterialState.focused,
    //   };
    //   if (states.any(interactiveStates.contains)) {
    //     return Colors.grey;
    //   }
    //   return Colors.red;
    // }

    return Scaffold(
      floatingActionButton: GoBackButton(),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 40),
            Text(
              'Settings',
              style: TextStyle(fontSize: 30.0),
            ),
            SizedBox(
              height: 60,
            ),
            //TODO: Implement light, dark mode functionality
            //TODO: Refactor this later
            ToggleButtons(
              onPressed: (int index) {
                setState(() {
                  for (int buttonIndex = 0;
                      buttonIndex < isSelected.length;
                      buttonIndex++) {
                    if (buttonIndex == index) {
                      isSelected[buttonIndex] = true;
                    } else {
                      isSelected[buttonIndex] = false;
                    }
                  }
                });
              },
              isSelected: isSelected,
              children: const <Widget>[
                Text('Light'),
                Text('Dark'),
              ],
            ),
            SizedBox(
              height: 35,
            ),
            ElevatedButton(
              onPressed: () {
                //TODO: Implement change password
              },
              child: Text('Change password for account'),
            ),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {
                //TODO: Implement options to delete account, or erase content
              },
              child: Text('Advanced account options'),
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
              style: ElevatedButton.styleFrom(primary: Colors.white70),
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
              style: ElevatedButton.styleFrom(primary: Colors.white70),
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
