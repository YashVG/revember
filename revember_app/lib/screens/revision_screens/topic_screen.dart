// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:revember_app/services/revision_services/get_topichash.dart';
import 'package:revember_app/services/revision_services/get_topics.dart';
import '../../services/revision_services/add_topic.dart';
import 'package:revember_app/constants/revision_constants.dart';
import 'notes_screen_desktop.dart';
import 'phone_screens/notes_screen_phone.dart';

class TopicScreen extends StatefulWidget {
  static const String id = 'topic_screen';

  const TopicScreen({Key? key}) : super(key: key);

  @override
  State<TopicScreen> createState() => _TopicScreenState();
}

class _TopicScreenState extends State<TopicScreen> {
  final TextEditingController topicInput = TextEditingController();
  @override
  Widget build(BuildContext context) {
    topicList;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pick a topic from $currentSubject',
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: size.width * 0.1),
            child: GestureDetector(
              onTap: () async {
                // Navigator.pushNamed(context, CreateSubjectScreen.id);
                return showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Enter topic name'),
                      content: TextField(
                        onChanged: (value) {
                          topicInput.text = value;
                        },
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Cancel'),
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                        ),
                        TextButton(
                          onPressed: () async {
                            await addTopic(topicInput.text);
                            Navigator.pop(context);
                            await getTopics();
                            setState(() {});
                          },
                          child: const Text('Create topic'),
                        )
                      ],
                    );
                  },
                );
              },
              child: CircleAvatar(
                backgroundColor: Colors.black,
                child: Icon(
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
          crossAxisCount: 3,
          crossAxisSpacing: size.width * 0.03,
          mainAxisSpacing: size.height * 0.05,
          children: [
            for (var i in topicList)
              ElevatedButton(
                onPressed: () async {
                  currentTopic = i.toString();
                  currentTopicHash = await getTopicHash(currentTopic);
                  if (Platform.isIOS || Platform.isIOS) {
                    Navigator.pushNamed(context, NotesScreenPhone.id);
                  } else {
                    Navigator.pushNamed(context, NotesScreenDesktop.id);
                  }
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
