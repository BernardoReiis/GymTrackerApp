import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../models/fingerprint.dart';
import '../../models/user.dart';
import '../../services/database.dart';

class AvgTrainingTime extends StatefulWidget {
  final UserData userData;
  const AvgTrainingTime({super.key, required this.userData});

  @override
  State<AvgTrainingTime> createState() => _AvgTrainingTimeState();
}

class _AvgTrainingTimeState extends State<AvgTrainingTime> {
  @override
  Widget build(BuildContext context) {
    List<TrainingData> chartData = [];

    return StreamBuilder<List<FingerPrintData>>(
        stream: DatabaseService(uid: widget.userData.uid)
            .fingerprintsForStats(widget.userData.fingerprintId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<FingerPrintData> alltrainings = snapshot.data!;
            if (alltrainings.isNotEmpty) {
              chartData = groupTrainingData(alltrainings);
            }
            return Container(
                height: MediaQuery.of(context).size.height * 0.4,
                child: SfCartesianChart(
                    primaryXAxis: DateTimeAxis(),
                    series: <ChartSeries>[
                      LineSeries<TrainingData, DateTime>(
                          dataSource: chartData,
                          xValueMapper: (TrainingData sales, _) => sales.year,
                          yValueMapper: (TrainingData sales, _) => sales.sales)
                    ]));
          } else {
            return Container();
          }
        });
  }
}

List<TrainingData> groupTrainingData(List<FingerPrintData> alltrainings) {
  List<TrainingData> result = [];
  if (alltrainings.length % 2 != 0) {
    alltrainings.removeAt(0);
  }
  for (int i = 0; i < alltrainings.length; i = i + 2) {
    DateTime dateday = DateTime.fromMillisecondsSinceEpoch(
        alltrainings[i].dataTime.toInt() * 1000);
    double duration = (alltrainings[i].dataTime.toInt() -
            alltrainings[i + 1].dataTime.toInt()) /
        60;
    result.add(TrainingData(dateday, duration));
  }
  return result;
}

class TrainingData {
  TrainingData(this.year, this.sales);
  final DateTime year;
  final double sales;
}
