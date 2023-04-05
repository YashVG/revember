import 'package:flutter/material.dart';

class StatsScreen extends StatefulWidget {
  static const String id = 'stats_screen';
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stats for topic'),
      ),
    );
  }
}
