// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:revember_app/constants/revision_constants.dart';
import 'package:revember_app/screens/revision_screens/writing_screens/writing_guide.dart';
import 'writing_screens/write_notes.dart';

import 'package:revember_app/screens/revision_screens/writing_screens/write_notes.dart';
import 'package:revember_app/screens/revision_screens/question_screens/main_question_screen.dart';
import 'package:revember_app/services/revision_services/get_notes.dart';

class NotesScreenDesktop extends StatefulWidget {
  const NotesScreenDesktop({Key? key}) : super(key: key);
  static const String id = 'notes_screen';

  @override
  State<NotesScreenDesktop> createState() => _NotesScreenDesktopState();
}

class _NotesScreenDesktopState extends State<NotesScreenDesktop> {
  String rawNotes = '';
  List notesToDisplay = [];

  List<String> splitByHyphen(String str) {
    List<String> result = [];
    var temp = '';
    for (var i = 0; i < str.length; i++) {
      if (str[i] == '-') {
        if (temp.isNotEmpty) result.add(temp);
        temp = '-';
      } else {
        temp += str[i];
      }
    }
    if (temp.isNotEmpty) result.add(temp);
    return result;
  }

  retrieveNotes() async {
    rawNotes = await getNotes();
    return rawNotes;
  }

  @override
  void initState() {
    retrieveNotes().then((value) {
      notesToDisplay = splitByHyphen(value);
      print(notesToDisplay);
      setState(() {});
    });

    super.initState();
  }

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
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text('Notes from topic',
                            style: TextStyle(fontSize: 20)),
                        SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: notesToDisplay.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(notesToDisplay[index]),
                                        SizedBox(
                                          height: 10,
                                        )
                                      ],
                                    );
                                  },
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(150), // NEW
                          ),
                          child: Text('Notes writing'),
                          onPressed: () {
                            Navigator.pushNamed(context, NotesGuidesScreen.id);
                          },
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(150), // NEW
                          ),
                          child: Text('Notes upload'),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: TextButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50), // NEW
                      ),
                      child: Text('Go to questions'),
                      onPressed: () {},
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50), // NEW
                      ),
                      child: Text(
                          'display average %s, notes stats, etc. for topic'),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
