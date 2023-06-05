import '../../models/temperature.dart';
import '../../models/user.dart';
import '../../services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../../services/database.dart';

class ManagerHomePage extends StatefulWidget {
  final UserData userData;
  const ManagerHomePage({super.key, required this.userData});

  @override
  State<ManagerHomePage> createState() => _ManagerHomePageState();
}

class _ManagerHomePageState extends State<ManagerHomePage> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBarGT(userData: widget.userData),
    );
  }
}

class AppBarGT extends StatelessWidget {
  final UserData userData;
  const AppBarGT({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<TemperatureData?>.value(
      initialData: null,
      value: DatabaseService(uid: userData.uid).temperatureShowManagerHome,
      child: Container(
        decoration: const BoxDecoration(
            color: Color.fromRGBO(191, 76, 76, 1),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12))),
        constraints: BoxConstraints.expand(
            height: MediaQuery.of(context).size.height * 0.35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            managerProfileGT(userData),
            IconsStatsGT(userData: userData),
          ],
        ),
      ),
    );
  }
}

Widget managerProfileGT(UserData userData) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      managerNameGT(userData),
      Image.asset('images/manager-photo.png')
    ],
  );
}

Widget managerNameGT(UserData userData) {
  final now = DateTime.now();
  String timeGT = DateFormat('yMMMEd').format(now);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        timeGT,
        style: const TextStyle(
            fontSize: 15, color: Colors.white, fontWeight: FontWeight.w400),
      ),
      Text(
        "Hello ${userData.username}",
        style: const TextStyle(
            fontSize: 27, color: Colors.white, fontWeight: FontWeight.w400),
      ),
    ],
  );
}

class IconsStatsGT extends StatelessWidget {
  final UserData userData;
  const IconsStatsGT({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    final temperatureToShow = Provider.of<TemperatureData?>(context);
    return Container(
        decoration: const BoxDecoration(
            color: Color.fromRGBO(255, 254, 254, 0.95),
            borderRadius: BorderRadius.all(Radius.circular(12))),
        constraints: BoxConstraints.expand(
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.width * 0.85),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            iconStat("images/people-group.png", "Total Members", "19"),
            iconStat("images/thermometer-icon.png", "Rooms \nTemperature",
                temperatureValue(temperatureToShow)),
            iconStat("images/zumba-icon.png", "Members Training", "4")
          ],
        ));
  }
}

String temperatureValue(TemperatureData? temperatureToShow) {
  if (temperatureToShow == null) {
    return "0.0";
  } else {
    return temperatureToShow.temperature.toStringAsFixed(1);
  }
}

Widget iconStat(String iconName, String textDefault, String textNumber) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
              color: Color.fromRGBO(191, 76, 76, 1),
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Image.asset(iconName)),
      Text(
        textNumber,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 10, color: Colors.black, fontWeight: FontWeight.w500),
      ),
      Text(
        textDefault,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 10, color: Colors.black, fontWeight: FontWeight.w500),
      ),
    ],
  );
}
