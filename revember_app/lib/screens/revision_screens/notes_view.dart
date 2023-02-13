import 'package:flutter/material.dart';

import '../../components/back_button.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});
  static const String id = 'notes_view_screen';

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: GoBackButton(),
      body: Container(
        padding: EdgeInsets.fromLTRB(
            size.height * 0.1, size.height * 0.1, size.height * 0.1, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: size.height * 0.1),
            Center(
              child: Text(
                "China's GDP is set to overtake America's",
                style: TextStyle(fontSize: 21),
              ),
            ),
            SizedBox(height: size.height * 0.075),
            Center(
              child: Text(
                'China GDP: 20 trillion dollars',
                style: TextStyle(fontSize: 21),
              ),
            ),
            SizedBox(height: size.height * 0.075),
            Center(
              child: Text('Economy is strong due to 1.3 billion people',
                  style: TextStyle(
                    fontSize: 21,
                  )),
            ),
            SizedBox(
              height: size.height * 0.075,
            ),
            Center(
              child: Text("Chinese banking sector grew by 11.4% last year",
                  style: TextStyle(
                    fontSize: 21,
                  )),
            ),
            SizedBox(height: size.height * 0.05),
          ],
        ),
      ),
    );
  }
}
