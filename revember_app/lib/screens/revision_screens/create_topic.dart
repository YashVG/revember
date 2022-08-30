import 'package:flutter/material.dart';
import 'package:revember_app/screens/revision_screens/topic_screen.dart';
import 'package:revember_app/services/revision_services/add_topic.dart';

class CreateTopicScreen extends StatefulWidget {
  static const String id = 'create_topic';

  const CreateTopicScreen({Key? key}) : super(key: key);

  @override
  State<CreateTopicScreen> createState() => _CreateTopicScreenState();
}

class _CreateTopicScreenState extends State<CreateTopicScreen> {
  late String topicTitle;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add topic'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: EdgeInsets.all(45), //change
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                topicTitle = value;
              },
              decoration: InputDecoration(
                labelText: "Enter topic name",
              ),
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () async {
                await addTopic(topicTitle);
                return showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Success!'),
                      content: Text('Top has been successfully added'),
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
              child: Text('Add topic'),
            ),
          ],
        ),
      ),
    );
  }
}
