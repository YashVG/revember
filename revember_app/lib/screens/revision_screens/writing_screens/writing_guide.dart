// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:revember_app/components/back_button.dart';
import 'package:revember_app/screens/revision_screens/writing_screens/write_notes.dart';

class NotesGuidesScreen extends StatelessWidget {
  static const String id = 'guide_screen';

  const NotesGuidesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Guide for writing notes'),
      ),
      body: Container(
        padding:
            EdgeInsets.fromLTRB(size.height * 0.1, 0, size.height * 0.1, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: size.height * 0.11),
            Center(
              child: Text(
                'Step 1. Write down your notes as you normally would',
                style: TextStyle(fontSize: 21),
              ),
            ),
            SizedBox(height: size.height * 0.075),
            Center(
              child: Text(
                'Step 2. Look through your notes and see how you can make them more concise.',
                style: TextStyle(fontSize: 21),
              ),
            ),
            SizedBox(height: size.height * 0.075),
            Center(
              child: Text(
                  'Step 3. Once you have written your preliminary notes, enter your new more concise notes into the section provided.',
                  style: TextStyle(
                    fontSize: 21,
                  )),
            ),
            SizedBox(
              height: size.height * 0.075,
            ),
            Center(
              child: Text(
                  "Step 4. Use the hypen (-) to split separate points or sentences.",
                  style: TextStyle(
                    fontSize: 21,
                  )),
            ),
            SizedBox(height: size.height * 0.05),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.redAccent, //background color of button
                    side: BorderSide(
                        width: 3, color: Colors.brown), //border width and color
                    elevation: 3, //elevation of button
                    padding: EdgeInsets.all(20)),
                onPressed: () {
                  Navigator.pushNamed(context, WriteNotesScreen.id);
                },
                child: Text('Proceed'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
