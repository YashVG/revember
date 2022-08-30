// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';

class WriteNotesScreen extends StatefulWidget {
  const WriteNotesScreen({Key? key}) : super(key: key);
  static const String id = 'write_notes_screen';

  @override
  State<WriteNotesScreen> createState() => _WriteNotesScreenState();
}

class _WriteNotesScreenState extends State<WriteNotesScreen> {
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
                        child: TextField(
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
                        onPressed: null,
                        child: Text('Click if notes completed'),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        child: TextField(
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
                        onPressed: null,
                        child: Text('Click to analyze notes'),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
