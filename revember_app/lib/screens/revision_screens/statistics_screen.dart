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
  late int numberComparison;
  late dynamic percentages;
  double percents = 0;
  late Map<String, double> percentagesDataMap;

  getValues() async {
    //set default values for async vars
    percentagesDataMap = {
      "No notes detected\nPlease input notes": 0,
    };
    numberComparison = 0;

    //percentages process
    percentages = await getDartPercentage(currentTopicHash);
    //gets average percentage
    var length = percentages.length;
    for (var number in percentages) {
      percents += number;
    }
    percents = (percents / length).roundToDouble();
    if (percents == 0.0 || percents.isNaN) {
    } else {
      percentagesDataMap = {
        "Words used": percents,
        "Words not used": 100 - percents
      };
      setState(() {});
    }

    //number comparison process
    numberComparison = await getDartComparison(currentTopicHash);
    setState(() {});
    print(numberComparison);
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
                    flex: 2,
                    child: Column(
                      children: [
                        const Text(
                          'Percentage of words used in concise notes compared to raw notes.\n\nIdeally keep the words used % as high as possible',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        PieChart(
                          dataMap: percentagesDataMap,
                          chartRadius: MediaQuery.of(context).size.width / 1,
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValuesInPercentage: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          'Total difference in word count between long notes and concise notes for this topic:',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          numberComparison.toString(),
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: const [
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
