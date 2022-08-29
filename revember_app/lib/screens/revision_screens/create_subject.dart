// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:revember_app/constants/user_constants.dart';

import 'package:flutter/material.dart';
import 'package:revember_app/services/revision_services/add_subject.dart';
import 'package:revember_app/services/revision_services/add_topic.dart';

class CreateSubjectScreen extends StatefulWidget {
  static const String id = 'create_subject';

  const CreateSubjectScreen({Key? key}) : super(key: key);

  @override
  State<CreateSubjectScreen> createState() => _CreateSubjectScreenState();
}

class _CreateSubjectScreenState extends State<CreateSubjectScreen> {
  late String subjectTitle;
  late String topicTitle = 'Topic 1';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add subject'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: EdgeInsets.all(45), //change
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                subjectTitle = value;
              },
              decoration: InputDecoration(
                labelText: "Enter subject name",
              ),
            ),
            SizedBox(
              height: 50,
            ),
            TextField(
              onChanged: (value) {
                topicTitle = value;
              },
              decoration: InputDecoration(
                labelText: "Enter topic name",
                hintText: "You need to input at least one topic",
              ),
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () async {
                await addSubjectAndTopic(subjectTitle, topicTitle);
              },
              child: Text('Add subject and topic'),
            ),
          ],
        ),
      ),
    );
  }
}
