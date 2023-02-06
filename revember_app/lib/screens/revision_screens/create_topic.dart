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
        title: const Text('Add topic'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(45), //change
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                topicTitle = value;
              },
              decoration: const InputDecoration(
                labelText: "Enter topic name",
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () async {
                await addTopic(topicTitle);
                return showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Success!'),
                      content: const Text('Top has been successfully added'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Okay!'),
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Add topic'),
            ),
          ],
        ),
      ),
    );
  }
}
