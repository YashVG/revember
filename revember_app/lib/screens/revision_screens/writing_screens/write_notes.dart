// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:revember_app/services/revision_services/upload_notes.dart';

class WriteNotesScreen extends StatefulWidget {
  const WriteNotesScreen({Key? key}) : super(key: key);
  static const String id = 'write_notes_screen';

  @override
  State<WriteNotesScreen> createState() => _WriteNotesScreenState();
}

class _WriteNotesScreenState extends State<WriteNotesScreen> {
  bool _enabled = true;
  bool _enabled2 = true;
  String notes = '';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        automaticallyImplyLeading: false,
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
                            primary: _enabled ? Colors.blue : Colors.grey),
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
                            primary: _enabled2 ? Colors.blue : Colors.grey),
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
                                    Navigator.pop(context);
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
