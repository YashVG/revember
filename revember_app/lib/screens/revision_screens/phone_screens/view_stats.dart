import 'package:flutter/material.dart';

class ViewStatsPhone extends StatefulWidget {
  const ViewStatsPhone({super.key});

  @override
  State<ViewStatsPhone> createState() => _ViewStatsPhoneState();
}

class _ViewStatsPhoneState extends State<ViewStatsPhone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stats')),
    );
  }
}
