import 'package:flutter/material.dart';
import 'package:revember_app/constants/revision_constants.dart';
import 'package:revember_app/services/stats_services/get_dart_stats.dart';
import 'package:pie_chart/pie_chart.dart';

class StatsScreen extends StatefulWidget {
  static const String id = 'stats_screen';
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  late dynamic percentages;
  double percents = 0;
  late Map<String, double> percentagesDataMap;

  getValues() async {
    percentagesDataMap = {
      "No notes detected\nPlease input notes": 0,
    };
    percentages = await getDartPercentage(currentTopicHash);

    var length = percentages.length;
    for (var number in percentages) {
      percents += number;
    }
    percents = (percents / length).roundToDouble();
    if (percents == 0.0) {
    } else {
      percentagesDataMap = {
        "Words used": percents,
        "Words not used": 100 - percents
      };
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getValues();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Stats for $currentTopic'),
      ),
      body: Padding(
        padding: EdgeInsets.all(size.height * 0.05),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const Text(
                          'Stats to show percentage of words used in concise notes compared to raw notes',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        PieChart(
                          dataMap: percentagesDataMap,
                          chartRadius: MediaQuery.of(context).size.width / 5,
                        ),
                      ],
                    ),
                  ),
                  const Expanded(
                    child: Text('Stats 2'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Text('Stats 3'),
                  ),
                  Expanded(
                    child: Text('Stats 4'),
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
