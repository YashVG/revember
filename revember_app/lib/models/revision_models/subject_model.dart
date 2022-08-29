import 'package:flutter/material.dart';

class RevisionTemplate extends StatefulWidget {
  List<String> subject_titles;

  RevisionTemplate({required this.subject_titles});

  @override
  State<RevisionTemplate> createState() => _RevisionTemplateState();
}

class _RevisionTemplateState extends State<RevisionTemplate> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GridView.count(
      childAspectRatio: size.aspectRatio * 1.5,
      crossAxisCount: 2,
      crossAxisSpacing: size.width * 0.03,
      mainAxisSpacing: size.height * 0.05,
      children: [],
    );
  }
}
