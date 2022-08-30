import 'package:flutter/material.dart';
import 'create_topic.dart';
import 'package:revember_app/constants/revision_constants.dart';
import 'notes_screen.dart';

class TopicScreen extends StatefulWidget {
  static const String id = 'topic_screen';

  const TopicScreen({Key? key}) : super(key: key);

  @override
  State<TopicScreen> createState() => _TopicScreenState();
}

class _TopicScreenState extends State<TopicScreen> {
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
              onTap: () {
                Navigator.pushNamed(context, CreateTopicScreen.id);
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
                onPressed: () {
                  currentTopic = i.toString();
                  Navigator.pushNamed(context, NotesScreen.id);
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
