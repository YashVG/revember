// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:revember_app/constants/revision_constants.dart';
import 'package:revember_app/screens/revision_screens/writing_screens/writing_guide.dart';
import 'writing_screens/write_notes.dart';
import 'dart:io' show Platform;

import 'package:revember_app/screens/revision_screens/writing_screens/write_notes.dart';
import 'package:revember_app/screens/revision_screens/question_screens/main_question_screen.dart';

class NotesScreenDesktop extends StatefulWidget {
  const NotesScreenDesktop({Key? key}) : super(key: key);
  static const String id = 'notes_screen';

  @override
  State<NotesScreenDesktop> createState() => _NotesScreenDesktopState();
}

class _NotesScreenDesktopState extends State<NotesScreenDesktop> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Notes and Questions from $currentTopic'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
          padding: EdgeInsets.all(size.height * 0.05),
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: null, child: Text('Upload document to scan')),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, NotesGuidesScreen.id);
                    },
                    child: Text('Write notes'),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, MainQuestionScreen.id);
                      },
                      child: Text('Questions'))
                ],
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Style'),
                ],
              ),
              SizedBox(
                height: size.height * 0.05,
              )
            ],
          )),
    );
  }
}
