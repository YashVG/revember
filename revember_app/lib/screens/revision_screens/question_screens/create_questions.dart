// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:revember_app/services/revision_services/add_user_question.dart';

class CreateQuestionScreen extends StatefulWidget {
  const CreateQuestionScreen({Key? key}) : super(key: key);
  static const String id = 'create_question_screen';

  @override
  State<CreateQuestionScreen> createState() => _CreateQuestionScreenState();
}

class _CreateQuestionScreenState extends State<CreateQuestionScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String question = '';
    String answer1 = '';
    String answer2 = '';
    String answer3 = '';
    String answer4 = '';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('Create questions'),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(size.width * 0.2, 0, size.width * 0.2, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.04,
              ),
              SizedBox(
                child: TextFormField(
                  onChanged: (value) {},
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText:
                          "Enter a sentence or phrase that you want remember"),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
                width: size.width,
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              SizedBox(
                child: TextFormField(
                  onChanged: (value) {
                    answer1 = value;
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: "What is the hardest word to remember"),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
                width: size.width * 0.4,
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              Text(
                'Now input three different answers that are similar to above',
                style: TextStyle(fontSize: size.height * 0.03),
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              Row(
                children: [
                  SizedBox(
                    child: TextFormField(
                      onChanged: (value) {
                        answer2 = value;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          hintText: "Answer 1"),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                    ),
                    width: size.width * 0.15,
                  ),
                  SizedBox(
                    width: size.width * 0.05,
                  ),
                  SizedBox(
                    child: TextFormField(
                      onChanged: (value) {
                        answer3 = value;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          hintText: "Answer 2"),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                    ),
                    width: size.width * 0.15,
                  ),
                  SizedBox(
                    width: size.width * 0.05,
                  ),
                  SizedBox(
                    child: TextFormField(
                      onChanged: (value) {
                        answer4 = value;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          hintText: "Answer 3"),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                    ),
                    width: size.width * 0.15,
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              SizedBox(
                child: TextFormField(
                  onChanged: (value) {
                    question = value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText:
                        "Rewrite the phrase and replace the word with ___",
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (question == '' ||
                      answer1 == '' ||
                      answer2 == '' ||
                      answer3 == '' ||
                      answer4 == '') {
                    return showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Error!'),
                            content: Text('One or more fields are left blank!'),
                            actions: <Widget>[
                              TextButton(
                                child: Text('Okay'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        });
                  }
                  await addUserMadeQuestion(
                      question, answer1, answer2, answer3, answer4);

                  // ignore: use_build_context_synchronously
                  return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Success!'),
                        content: Text('Question added successfully!'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Okay'),
                            onPressed: () {
                              int count = 0;
                              Navigator.popUntil(context, (route) {
                                return count++ == 2;
                              });
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text('Create question'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
