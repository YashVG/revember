// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:revember_app/screens/revision_screens/notes_screen_desktop.dart';
import 'package:revember_app/services/revision_services/upload_notes.dart';
import 'package:revember_app/services/stats_services/dart_stats.dart';

class WriteNotesScreen extends StatefulWidget {
  const WriteNotesScreen({Key? key}) : super(key: key);
  static const String id = 'write_notes_screen';

  @override
  State<WriteNotesScreen> createState() => _WriteNotesScreenState();
}

class _WriteNotesScreenState extends State<WriteNotesScreen> {
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
                        wordPercentageComparison(rawNotes, notes);

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
              SizedBox(
                height: size.height * 0.1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
