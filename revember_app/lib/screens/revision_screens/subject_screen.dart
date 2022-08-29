// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:revember_app/constants/revision_constants.dart';
import 'package:flutter/material.dart';
import 'package:revember_app/services/revision_services/get_subjects.dart';
import 'create_subject.dart';
import 'topic_screen.dart';

class SubjectScreen extends StatefulWidget {
  static const String id = 'subject_screen';
  const SubjectScreen({Key? key}) : super(key: key);

  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  @override
  Widget build(BuildContext context) {
    subjectList;
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
        padding: EdgeInsets.symmetric(
            horizontal: size.height * 0.02, vertical: size.height * 0.02),
        child: GridView.count(
          childAspectRatio: size.aspectRatio * 1.5,
          crossAxisCount: 2,
          crossAxisSpacing: size.width * 0.03,
          mainAxisSpacing: size.height * 0.05,
          children: [
            for (var i in subjectList)
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, TopicScreen.id);
                },
                child: Text(
                  i.toString(),
                  style: TextStyle(fontSize: size.width * 0.04),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
