// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:revember_app/constants/revision_constants.dart';
import 'package:revember_app/quiz_variables/variables.dart';
import 'package:revember_app/screens/quiz_screens/easy_quiz_screen.dart';
import 'package:revember_app/screens/revision_screens/question_screens/create_questions.dart';
import 'package:revember_app/screens/revision_screens/statistics_screen.dart';
import 'package:revember_app/screens/revision_screens/writing_screens/writing_guide.dart';
import 'package:revember_app/services/question_services/get_easy_questions.dart';
import 'package:revember_app/services/question_services/get_hard_questions.dart';
import 'package:revember_app/services/question_services/get_medium_questions.dart';

import 'package:revember_app/services/revision_services/get_notes.dart';
import 'package:revember_app/services/question_services/get_user_questions.dart';
import 'package:revember_app/services/revision_services/split_hypen.dart';

import '../../services/stats_services/get_dart_stats.dart';
import '../quiz_screens/hard_quiz_screen.dart';
import '../quiz_screens/medium_quiz_screen.dart';

class NotesScreenDesktop extends StatefulWidget {
  const NotesScreenDesktop({Key? key}) : super(key: key);
  static const String id = 'notes_screen';

  @override
  State<NotesScreenDesktop> createState() => _NotesScreenDesktopState();
}

class _NotesScreenDesktopState extends State<NotesScreenDesktop> {
  String rawNotes = '';
  List notesToDisplay = [];

  retrieveNotes() async {
    rawNotes = await getNotes();
    return rawNotes;
  }

  @override
  void initState() {
    retrieveNotes().then(
      (value) {
        notesToDisplay = splitByHyphen(value);
        setState(() {});
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(currentTopic),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: EdgeInsets.all(size.height * 0.05),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text('Notes from topic',
                            style: TextStyle(fontSize: 22)),
                        SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                rawNotes == ""
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'No notes available, please write some',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.red),
                                          )
                                        ],
                                      )
                                    : ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemCount: notesToDisplay.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                notesToDisplay[index],
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              )
                                            ],
                                          );
                                        },
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(100), // NEW
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Write notes',
                                style: TextStyle(fontSize: 30),
                              ),
                              SizedBox(height: 10),
                              Icon(Icons.article_rounded),
                            ],
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, NotesGuidesScreen.id);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(50), // NEW
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 30,
                                ),
                                Text(
                                  'Create questions',
                                  style: TextStyle(fontSize: 30),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.add,
                                  size: 30.0,
                                )
                              ],
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, CreateQuestionScreen.id);
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(50), // NEW
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 30,
                                ),
                                Text(
                                  'Answer Questions',
                                  style: TextStyle(fontSize: 30),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.arrow_right,
                                  size: 30.0,
                                )
                              ],
                            ),
                            onPressed: () async {
                              return showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Choose difficulty:'),
                                    actions: <Widget>[
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              TextButton(
                                                child: Text('Easy'),
                                                onPressed: () async {
                                                  await getEasyQuestionsAndAnswers(
                                                      currentTopicHash);
                                                  if (questions.isEmpty) {
                                                    return showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          title: Text(
                                                              'No questions detected!'),
                                                          content: Text(
                                                            'Please input notes to get questions',
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red),
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child:
                                                                  Text('Okay'),
                                                            )
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  } else {
                                                    Navigator.pushNamed(context,
                                                        EasyTestQuizScreen.id);
                                                  }
                                                },
                                              ),
                                              TextButton(
                                                child: Text('Medium'),
                                                onPressed: () async {
                                                  if (questions.isEmpty) {
                                                    return showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          title: Text(
                                                            'No questions detected!',
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red),
                                                          ),
                                                          content: Text(
                                                              'Please input notes to get questions'),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child:
                                                                  Text('Okay'),
                                                            )
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  } else {
                                                    await getMediumQuestionsAndAnswers(
                                                        currentTopicHash);
                                                    Navigator.pushNamed(
                                                        context,
                                                        MediumTestQuizScreen
                                                            .id);
                                                  }
                                                },
                                              ),
                                              TextButton(
                                                child: Text('Hard'),
                                                onPressed: () async {
                                                  if (questions.isEmpty) {
                                                    return showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          title: Text(
                                                            'No questions detected!',
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red),
                                                          ),
                                                          content: Text(
                                                              'Please input notes to get questions'),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child:
                                                                  Text('Okay'),
                                                            )
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  } else {
                                                    await getHardQuestionsAndAnswers(
                                                        currentTopicHash);
                                                    Navigator.pushNamed(context,
                                                        HardTestQuizScreen.id);
                                                  }
                                                },
                                              ),
                                              TextButton(
                                                child: Text('User-Made'),
                                                onPressed: () async {
                                                  await getUserMadeQuestionsAndAnswers(
                                                      currentTopicHash);
                                                  if (questions.isEmpty) {
                                                    return showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          title: Text(
                                                            'No questions detected!',
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red),
                                                          ),
                                                          content: Text(
                                                              'Please create some questions'),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child:
                                                                  Text('Okay'),
                                                            )
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  } else {
                                                    Navigator.pushNamed(
                                                        context,
                                                        MediumTestQuizScreen
                                                            .id);
                                                  }
                                                },
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          )
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50), // NEW
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            'Statistics for topic',
                            style: TextStyle(fontSize: 30),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.percent)
                        ],
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, StatsScreen.id);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
