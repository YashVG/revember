import 'package:flutter/material.dart';
import 'package:revember_app/components/back_button.dart';
import 'package:revember_app/screens/revision_screens/question_screens/create_questions.dart';
import 'package:revember_app/screens/revision_screens/writing_screens/write_notes.dart';

class QuestionGuide extends StatelessWidget {
  static const String id = 'question_guide';

  const QuestionGuide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: GoBackButton(),
      body: Container(
        padding:
            EdgeInsets.fromLTRB(size.height * 0.1, 0, size.height * 0.1, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: size.height * 0.11),
            Center(
              child: Text(
                'Guide for creating questions',
                style: TextStyle(fontSize: 36),
              ),
            ),
            SizedBox(height: size.height * 0.1),
            Center(
              child: Text(
                'Step 1. Create fill-in-the-blank questions',
                style: TextStyle(fontSize: 21),
              ),
            ),
            SizedBox(height: size.height * 0.075),
            Center(
              child: Text(
                'Step 2. Look for a key fact, name or figure that you have trouble remembering',
                style: TextStyle(fontSize: 21),
              ),
            ),
            SizedBox(height: size.height * 0.075),
            Center(
              child: Text(
                  'Step 3. Once done, add that as one of your answer options, and create three other similar answer options that are incorrect',
                  style: TextStyle(
                    fontSize: 21,
                  )),
            ),
            SizedBox(
              height: size.height * 0.075,
            ),
            Center(
              child: Text(
                "Step 4. From the question, replace the word with underscores (____)",
                style: TextStyle(
                  fontSize: 21,
                ),
              ),
            ),
            SizedBox(height: size.height * 0.05),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.redAccent, //background color of button
                    side: BorderSide(
                        width: 3, color: Colors.brown), //border width and color
                    elevation: 3, //elevation of button
                    padding: EdgeInsets.all(20)),
                onPressed: () {
                  Navigator.pushNamed(context, CreateQuestionScreen.id);
                },
                child: Text('Proceed'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
