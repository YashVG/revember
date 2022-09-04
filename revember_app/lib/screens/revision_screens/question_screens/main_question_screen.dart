import 'package:flutter/material.dart';
import 'create_questions.dart';
import 'question_guide.dart';

class MainQuestionScreen extends StatefulWidget {
  const MainQuestionScreen({Key? key}) : super(key: key);
  static const String id = 'main_question_screen';

  @override
  State<MainQuestionScreen> createState() => _MainQuestionScreenState();
}

class _MainQuestionScreenState extends State<MainQuestionScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("Choose questions or create your own"),
      ),
      body: Padding(
        padding: EdgeInsets.all(size.height * 0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, QuestionGuide.id);
                  },
                  child: Icon(
                    Icons.add,
                  ),
                ),
                Text('⬅️ Choose to add your own questions, or delete them ➡️'),
                ElevatedButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.delete,
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.1),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Easy',
                  style: TextStyle(fontSize: size.height * 0.05),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Medium',
                    style: TextStyle(fontSize: size.height * 0.05)),
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Hard',
                    style: TextStyle(fontSize: size.height * 0.05)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
