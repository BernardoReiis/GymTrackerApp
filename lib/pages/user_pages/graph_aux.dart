import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarChartSample1 extends StatefulWidget {
  BarChartSample1({super.key});

  final Color barBackgroundColor = Colors.grey.shade200;
  final Color barColor = Color.fromRGBO(191, 76, 76, 1);
  final Color touchedBarColor = Colors.green;

  @override
  State<StatefulWidget> createState() => BarChartSample1State();
}

class BarChartSample1State extends State<BarChartSample1> {
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;

  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.2,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Text(
                  'Workouts Per Week',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                const SizedBox(
                  height: 38,
                ),
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: FutureBuilder(
                        future: yau(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return mainBarData(
                                snapshot.data![0],
                                snapshot.data![1],
                                snapshot.data![2],
                                snapshot.data![3],
                                snapshot.data![4],
                                snapshot.data![5],
                                snapshot.data![6],
                                snapshot.data!.reduce(max));
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      )),
                ),
                const SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int max,
    int x,
    double y, {
    bool isTouched = false,
    Color? barColor,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    barColor ??= widget.barColor;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: isTouched ? widget.touchedBarColor : barColor,
          width: width,
          borderSide: isTouched
              ? BorderSide(color: widget.touchedBarColor)
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: max.toDouble(),
            color: widget.barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups(int week1, int week2, int week3,
          int week4, int week5, int week6, int week7, int max) =>
      List.generate(7, (i) {
        max = (max / 2).toInt() + 2;
        switch (i) {
          case 0:
            return makeGroupData(max, 1, week1 / 2,
                isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(max, 2, week2 / 2,
                isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(max, 3, week3 / 2,
                isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(max, 4, week4 / 2,
                isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(max, 5, week5 / 2,
                isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(max, 6, week6 / 2,
                isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(max, 7, week7 / 2,
                isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
      });
  Future<List<int>> yau() async {
    int seconds = 604800;
    double now = DateTime.now().millisecondsSinceEpoch / 10e2;
    double restante = now % seconds;
    double next = restante + now;
    int week1 =
        await getNumWorkouts(next - (7 * seconds) + (1 * seconds) - 259505);
    int week2 =
        await getNumWorkouts(next - (7 * seconds) + (2 * seconds) - 259505);
    int week3 =
        await getNumWorkouts(next - (7 * seconds) + (3 * seconds) - 259505);
    int week4 =
        await getNumWorkouts(next - (7 * seconds) + (4 * seconds) - 259505);
    int week5 =
        await getNumWorkouts(next - (7 * seconds) + (5 * seconds) - 259505);
    int week6 =
        await getNumWorkouts(next - (7 * seconds) + (6 * seconds) - 259505);
    int week7 =
        await getNumWorkouts(next - (7 * seconds) + (7 * seconds) - 259505);
    return [week1, week2, week3, week4, week5, week6, week7];
  }

  BarChart mainBarData(week1, week2, week3, week4, week5, week6, week7, max) {
    return BarChart(
      BarChartData(
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            tooltipHorizontalAlignment: FLHorizontalAlignment.right,
            tooltipMargin: -10,
          ),
          touchCallback: (FlTouchEvent event, barTouchResponse) {
            setState(() {
              if (!event.isInterestedForInteractions ||
                  barTouchResponse == null ||
                  barTouchResponse.spot == null) {
                touchedIndex = -1;
                return;
              }
              touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
            });
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: getTitles,
              reservedSize: 38,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles:
                SideTitles(showTitles: true, interval: 1, reservedSize: 30),
          ),
        ),
        borderData: FlBorderData(
          show: false,
        ),
        barGroups:
            showingGroups(week1, week2, week3, week4, week5, week6, week7, max),
        gridData: FlGridData(show: false),
      ),
      swapAnimationDuration: animDuration,
    );
  }

  Future<int> getNumWorkouts(double timestamp) async {
    int seconds = 604799;
    final snap = await FirebaseFirestore.instance
        .collection('fingerprints')
        .where('data_time', isGreaterThanOrEqualTo: timestamp.toInt())
        .where('data_time', isLessThanOrEqualTo: timestamp.toInt() + seconds)
        .count()
        .get();
    return snap.count;
  }

  DateTime getDataTimeFormat(double timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp.toInt() * 1000);
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    int seconds = 604800;
    double now = DateTime.now().millisecondsSinceEpoch / 10e2;
    double restante = now % seconds;
    double next = restante + now;
    double last = next - (7 * seconds) + (value.toInt() * seconds) - 259505;
    DateTime referenceWeek =
        DateTime.fromMillisecondsSinceEpoch(last.toInt() * 1000);
    Widget text =
        Text('${referenceWeek.day}/${referenceWeek.month}', style: style);
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }
}
