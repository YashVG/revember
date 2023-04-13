// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:revember_app/constants/revision_constants.dart';
import 'package:revember_app/quiz_variables/variables.dart';
import 'package:revember_app/screens/quiz_screens/easy_quiz_screen.dart';
import 'package:revember_app/screens/quiz_screens/hard_quiz_screen.dart';
import 'package:revember_app/screens/quiz_screens/medium_quiz_screen.dart';
import 'package:revember_app/screens/revision_screens/phone_screens/view_notes.dart';
import 'package:revember_app/screens/revision_screens/phone_screens/view_stats.dart';
import 'package:revember_app/services/question_services/get_easy_questions.dart';
import 'package:revember_app/services/question_services/get_hard_questions.dart';
import 'package:revember_app/services/question_services/get_medium_questions.dart';
import 'package:revember_app/services/question_services/get_user_questions.dart';

class NotesScreenPhone extends StatelessWidget {
  const NotesScreenPhone({super.key});
  static const String id = 'notes_screen_phone';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(currentTopic),
      ),
      body: Padding(
        padding: EdgeInsets.all(size.height * 0.03),
        child: Column(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  Navigator.pushNamed(context, PhoneViewNotes.id);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), // <-- Radius
                  ),
                  minimumSize: const Size.fromHeight(100),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Notes',
                      style: TextStyle(fontSize: 50),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Icon(
                      Icons.notes,
                      size: 60,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        actionsAlignment: MainAxisAlignment.center,
                        title: const Text('Choose difficulty:'),
                        actions: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  TextButton(
                                    child: const Text(
                                      'Easy',
                                      style: TextStyle(fontSize: 22),
                                    ),
                                    onPressed: () async {
                                      if (questions.isEmpty) {
                                        return showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  'No questions detected!'),
                                              content: const Text(
                                                'Please input notes to get questions',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('Okay'),
                                                )
                                              ],
                                            );
                                          },
                                        );
                                      } else {
                                        await getEasyQuestionsAndAnswers(
                                            currentTopicHash);
                                        Navigator.pushNamed(
                                            context, EasyTestQuizScreen.id);
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextButton(
                                    child: const Text(
                                      'Medium',
                                      style: TextStyle(fontSize: 22),
                                    ),
                                    onPressed: () async {
                                      if (questions.isEmpty) {
                                        return showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  'No questions detected!'),
                                              content: const Text(
                                                'Please input notes to get questions',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('Okay'),
                                                )
                                              ],
                                            );
                                          },
                                        );
                                      } else {
                                        await getMediumQuestionsAndAnswers(
                                            currentTopicHash);
                                        Navigator.pushNamed(
                                            context, MediumTestQuizScreen.id);
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextButton(
                                    child: const Text(
                                      'Hard',
                                      style: TextStyle(fontSize: 22),
                                    ),
                                    onPressed: () async {
                                      if (questions.isEmpty) {
                                        return showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  'No questions detected!'),
                                              content: const Text(
                                                'Please input notes to get questions',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('Okay'),
                                                )
                                              ],
                                            );
                                          },
                                        );
                                      } else {
                                        await getHardQuestionsAndAnswers(
                                            currentTopicHash);
                                        Navigator.pushNamed(
                                            context, HardTestQuizScreen.id);
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextButton(
                                    child: const Text(
                                      'User-Made',
                                      style: TextStyle(fontSize: 22),
                                    ),
                                    onPressed: () async {
                                      if (questions.isEmpty) {
                                        return showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text(
                                                'No questions detected!',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                              content: const Text(
                                                  'Please create some questions'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('Okay'),
                                                )
                                              ],
                                            );
                                          },
                                        );
                                      } else {
                                        await getUserMadeQuestionsAndAnswers(
                                            currentTopicHash);
                                        Navigator.pushNamed(
                                            context, MediumTestQuizScreen.id);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), // <-- Radius
                  ),
                  minimumSize: const Size.fromHeight(100),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Questions',
                      style: TextStyle(fontSize: 50),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Icon(
                      Icons.question_mark_rounded,
                      size: 60,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, ViewStatsPhone.id);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), // <-- Radius
                  ),
                  minimumSize: const Size.fromHeight(100),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Statistics',
                      style: TextStyle(fontSize: 50),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Icon(
                      Icons.auto_graph,
                      size: 60,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
