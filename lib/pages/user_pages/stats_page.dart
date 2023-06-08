import 'dart:ffi';

import '../../models/user.dart';
import '../../services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';

import 'avg_training_time.dart';
import 'graph_aux.dart';

class UserStatsPage extends StatelessWidget {
  final UserData userData;
  const UserStatsPage({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stats"),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(191, 76, 76, 1),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BarChartSample1(userData: userData),
            SizedBox(height: 20),
            Text(
              'Training time per workout',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            AvgTrainingTime(userData: userData)
          ],
        ),
      ),
    );
  }
}
