import 'package:flutter/material.dart';
import 'package:revember_app/constants/revision_constants.dart';

class NotesScreenPhone extends StatefulWidget {
  const NotesScreenPhone({super.key});
  static const String id = 'notes_screen_phone';

  @override
  State<NotesScreenPhone> createState() => _NotesScreenPhoneState();
}

class _NotesScreenPhoneState extends State<NotesScreenPhone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(currentTopic),
      ),
      body: Column(),
    );
  }
}
