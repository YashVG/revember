// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:revember_app/constants/revision_constants.dart';
import 'package:revember_app/screens/revision_screens/writing_screens/guide.dart';
import 'writing_screens/write_notes.dart';
import 'dart:io' show Platform;

import 'package:revember_app/screens/revision_screens/writing_screens/write_notes.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);
  static const String id = 'notes_screen';

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Notes from $currentTopic'),
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
                  if (Platform.isAndroid || Platform.isIOS)
                    ElevatedButton(
                      onPressed: null,
                      child: Text('Scan Notes'),
                    ),
                  if (Platform.isMacOS || Platform.isWindows)
                    ElevatedButton(
                        onPressed: null,
                        child: Text('Upload document to scan')),
                  if (Platform.isMacOS || Platform.isWindows)
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, NotesGuides.id);
                      },
                      child: Text('Write notes'),
                    ),
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
