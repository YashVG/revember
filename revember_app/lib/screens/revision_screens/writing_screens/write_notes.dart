// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:revember_app/constants/revision_constants.dart';
import 'package:http/http.dart' as http;
import 'package:revember_app/screens/revision_screens/notes_screen_desktop.dart';
import 'package:revember_app/services/revision_services/upload_notes.dart';
import 'package:revember_app/services/stats_services/upload_dart_stats.dart';

class WriteNotesScreen extends StatefulWidget {
  const WriteNotesScreen({Key? key}) : super(key: key);
  static const String id = 'write_notes_screen';

  @override
  State<WriteNotesScreen> createState() => _WriteNotesScreenState();
}

class _WriteNotesScreenState extends State<WriteNotesScreen> {
  final data = {'value1': 'hello', 'value2': 'world'};

  void _sendDataForQuestions(String method) async {
    String apiUrl = 'http://127.0.0.1:5000/createQuestions';
    late http.Response response;
    //switch func used in case additional API methods need to be added later for future development
    switch (method) {
      case 'POST':
        response = await http.post(Uri.parse(apiUrl),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode([notes, currentTopicHash]));
        break;
    }

    if (response.statusCode == 200) {
      print('Data sent successfully!');
      print(response.body);
    } else {
      print('Error sending data: ${response.statusCode}');
    }
  }

  void _sendDataForStats(String method) async {
    String apiUrl = 'http://127.0.0.1:5000/stats';
    late http.Response response;
    //switch func used in case additional API methods need to be added later for future development
    switch (method) {
      case 'POST':
        response = await http.post(Uri.parse(apiUrl),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode([notes, currentTopicHash]));
        break;
    }

    if (response.statusCode == 200) {
      print('Data sent successfully!');
      print(response.body);
    } else {
      print('Error sending data: ${response.statusCode}');
    }
  }

  bool _enabled = true;
  bool _enabled2 = true;
  String rawNotes = '';
  String notes = '';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('Write your notes down'),
      ),
      body: Padding(
        padding:
            EdgeInsets.fromLTRB(size.width * 0.01, 0, size.width * 0.01, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        child: TextFormField(
                          onChanged: (value) {
                            rawNotes = value;
                          },
                          readOnly: !_enabled,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              hintText:
                                  'Enter your notes here...\nSeparate points with a hypen (-)'),
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                        ),
                        width: size.width * 0.4,
                      ),
                      SizedBox(height: size.height * 0.05),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                _enabled ? Colors.blue : Colors.grey),
                        onPressed: () {
                          _enabled = !_enabled;
                          setState(() {});
                        },
                        child: _enabled
                            ? Text("Click if notes completed")
                            : Text("Click if notes incomplete"),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        child: TextFormField(
                          onChanged: (value) {
                            notes = value;
                          },
                          readOnly: !_enabled2,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              hintText:
                                  "Enter your concise notes here...\nSeparate points with a hypen (-)"),
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                        ),
                        width: size.width * 0.4,
                      ),
                      SizedBox(height: size.height * 0.05),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                _enabled2 ? Colors.blue : Colors.grey),
                        onPressed: () {
                          _enabled2 = !_enabled2;
                          setState(() {});
                        },
                        child: _enabled2
                            ? Text("Click if concise notes completed")
                            : Text("Click if concise notes incomplete"),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: size.height * 0.1,
              ),
              ElevatedButton(
                onPressed: _enabled || _enabled2
                    ? null
                    : () async {
                        await uploadNotes(notes);
                        await uploadPercentage(
                          wordPercentageComparison(rawNotes, notes),
                        );
                        await uploadComparison(
                          wordComparison(rawNotes, notes),
                        );
                        _sendDataForStats('POST');
                        _sendDataForQuestions('POST');

                        // ignore: use_build_context_synchronously
                        return showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Success!'),
                              content:
                                  Text('Notes have been added successfully'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('Okay!'),
                                  onPressed: () async {
                                    //work around to update state of screen every time new notes are added
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.pushNamed(
                                        context, NotesScreenDesktop.id);
                                    setState(() {});
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                child: Text('Save and upload notes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
