import 'package:flutter/material.dart';

class TopicScreen extends StatefulWidget {
  static const String id = 'topic_screen';

  const TopicScreen({Key? key}) : super(key: key);

  @override
  State<TopicScreen> createState() => _TopicScreenState();
}

class _TopicScreenState extends State<TopicScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [Text('data')],
        ),
      ),
    );
  }
}
