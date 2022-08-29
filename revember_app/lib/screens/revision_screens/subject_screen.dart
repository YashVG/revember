// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'create_subject.dart';

class SubjectScreen extends StatefulWidget {
  static const String id = 'subject_screen';
  const SubjectScreen({Key? key}) : super(key: key);

  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pick a subject and start your revision',
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: size.width * 0.1),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, CreateSubjectScreen.id);
              },
              child: CircleAvatar(
                backgroundColor: Colors.black,
                child: Icon(
                  shadows: [],
                  color: Colors.white,
                  Icons.add,
                  size: 26.0,
                ),
              ),
            ),
          ),
        ],
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.height * 0.02),
        child: GridView.count(
          childAspectRatio: size.aspectRatio * 1.5,
          crossAxisCount: 2,
          crossAxisSpacing: size.width * 0.03,
          mainAxisSpacing: size.height * 0.05,
          children: [
            Text('hello'),
            Text('data'),
            Text('work'),
            Text('Work'),
          ],
        ),
      ),
    );
  }
}
