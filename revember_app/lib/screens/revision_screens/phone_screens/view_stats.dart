import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:revember_app/constants/revision_constants.dart';
import 'package:revember_app/services/stats_services/advanced_stats.dart';
import 'package:revember_app/services/stats_services/get_dart_stats.dart';

class ViewStatsPhone extends StatefulWidget {
  const ViewStatsPhone({super.key});
  static const String id = 'stats_screen_phone';

  @override
  State<ViewStatsPhone> createState() => _ViewStatsPhoneState();
}

class _ViewStatsPhoneState extends State<ViewStatsPhone> {
  late int numberComparison;
  late dynamic percentages;
  late dynamic advancedPercentages;
  double percents = 0;
  double advancedPercents = 0;
  late Map<String, double> percentagesDataMap;
  late Map<String, double> advancedPercentagesDataMap;

  getValues() async {
    //set default values for async vars
    percentagesDataMap = {
      "No notes detected\nPlease input notes": 0,
    };
    advancedPercentagesDataMap = {
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

    advancedPercentages = await getAdvancedStats(currentTopicHash);
    var length2 = advancedPercentages.length;
    for (var number in advancedPercentages) {
      advancedPercents += number;
    }
    advancedPercents = (advancedPercents / length).roundToDouble();
    if (advancedPercents == 0.0 || advancedPercents.isNaN) {
    } else {
      advancedPercentagesDataMap = {
        "Percentage of useful words in concise notes": advancedPercents,
        "Percentage of wasteful words": 100 - advancedPercents
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
        title: Text('Stats'),
      ),
      body: Padding(
        padding: EdgeInsets.all(size.height * 0.02),
        child: SingleChildScrollView(
          child: Column(children: [
            Column(
              children: [
                const Text(
                  'Percentage of words used in concise notes compared to raw notes.\n\nIdeally keep the words used % as high as possible',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                PieChart(
                  dataMap: percentagesDataMap,
                  chartRadius: MediaQuery.of(context).size.width / 0.7,
                  chartValuesOptions: const ChartValuesOptions(
                    showChartValuesInPercentage: true,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Total difference in word count between long notes and concise notes for this topic:',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '$numberComparison wasted words',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Percentage of useful words and entities.\n\nIdeally keep this % as high as possible',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                PieChart(
                  dataMap: advancedPercentagesDataMap,
                  chartRadius: MediaQuery.of(context).size.width / 3.5,
                  chartValuesOptions: const ChartValuesOptions(
                    showChartValuesInPercentage: true,
                  ),
                  legendOptions:
                      LegendOptions(legendPosition: LegendPosition.bottom),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
