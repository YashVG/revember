import 'package:flutter/material.dart';
import 'package:revember_app/services/revision_services/get_notes.dart';
import 'package:revember_app/services/revision_services/split_hypen.dart';

class PhoneViewNotes extends StatefulWidget {
  const PhoneViewNotes({super.key});
  static const String id = 'view_notes_phone';

  @override
  State<PhoneViewNotes> createState() => _PhoneViewNotesState();
}

class _PhoneViewNotesState extends State<PhoneViewNotes> {
  String rawNotes = 'Loading notes....';
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
        title: const Text('Notes'),
      ),
      body: Padding(
        padding: EdgeInsets.all(size.height * 0.03),
        child: SingleChildScrollView(
          child: Column(children: [
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: notesToDisplay.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      notesToDisplay[index],
                      style: const TextStyle(fontSize: 34),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Divider(color: Colors.black),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                );
              },
            ),
          ]),
        ),
      ),
    );
  }
}
