import '../../services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ManagerHomePage extends StatefulWidget {
  const ManagerHomePage({super.key});

  @override
  State<ManagerHomePage> createState() => _ManagerHomePageState();
}

class _ManagerHomePageState extends State<ManagerHomePage> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AppBarGT(),
    );
  }
}

class AppBarGT extends StatelessWidget {
  const AppBarGT({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Color.fromRGBO(191, 76, 76, 1),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12))),
      constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height * 0.35),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          ManagerProfileGT(),
          IconsStatsGT(),
        ],
      ),
    );
  }
}

class ManagerProfileGT extends StatelessWidget {
  const ManagerProfileGT({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [UserNameGT(), Image.asset('images/manager-photo.png')],
    );
  }
}

class UserNameGT extends StatelessWidget {
  UserNameGT({super.key});
  final now = DateTime.now();
  @override
  Widget build(BuildContext context) {
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
        const Text(
          "Hello Antonio",
          style: TextStyle(
              fontSize: 27, color: Colors.white, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}

class IconsStatsGT extends StatelessWidget {
  const IconsStatsGT({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            color: Color.fromRGBO(255, 254, 254, 0.95),
            borderRadius: BorderRadius.all(Radius.circular(12))),
        constraints: BoxConstraints.expand(
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.width * 0.85),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            IconStat(
              iconName: "images/calendar-icon.png",
              textDefault: "Times Per Week",
              textNumber: "3",
            ),
            IconStat(
              iconName: "images/stopwatch-icon.png",
              textDefault: "Avg. Training \nTime",
              textNumber: "3",
            ),
            IconStat(
              iconName: "images/zumba-icon.png",
              textDefault: "Group Classes \n Per Week",
              textNumber: "3",
            )
          ],
        ));
  }
}

class IconStat extends StatelessWidget {
  final String iconName;
  final String textDefault;
  final String textNumber;

  const IconStat(
      {super.key,
      required this.iconName,
      required this.textDefault,
      required this.textNumber});

  @override
  Widget build(BuildContext context) {
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
}
