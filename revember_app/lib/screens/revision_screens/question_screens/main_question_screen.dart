import 'package:flutter/material.dart';
import 'package:revember_app/constants/revision_constants.dart';
import 'package:revember_app/screens/quiz_screens/easy_quiz_screen.dart';
import 'package:revember_app/test/test_screen.dart';
import 'create_questions.dart';

import 'package:revember_app/test/test_query.dart';
import 'package:revember_app/services/question_services/get_user_questions.dart';

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
        title: const Text("Choose questions or create your own"),
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
                    Navigator.pushNamed(context, CreateQuestionScreen.id);
                  },
                  child: const Icon(
                    Icons.add,
                  ),
                ),
                const Text(
                    '⬅️ Choose to add your own questions, or delete them ➡️'),
                ElevatedButton(
                  onPressed: () async {
                    await addUserMadeQuestion1();
                    await addUserMadeQuestion2();
                    await addUserMadeQuestion3();
                    await addUserMadeQuestion4();
                  },
                  child: const Icon(
                    Icons.delete,
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.1),
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  await getUserMadeQuestionsAndAnswers(currentTopicHash);
                  Navigator.pushNamed(context, EasyTestQuizScreen.id);
                },
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
                onPressed: () {
                  Navigator.pushNamed(context, TestScreen.id);
                },
                child: Text('Medium',
                    style: TextStyle(fontSize: size.height * 0.05)),
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, TestScreen.id);
                },
                child: Text('Hard',
                    style: TextStyle(fontSize: size.height * 0.05)),
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, TestScreen.id);
                },
                child: Text('User-Generated',
                    style: TextStyle(fontSize: size.height * 0.05)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
